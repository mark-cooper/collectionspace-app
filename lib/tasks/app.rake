# Tasks for managing incoming data from collectionspace
require 'awesome_print'
require 'tempfile'

def puts_and_log(log, message)
  log.info message
  puts message.green
end

namespace :app do
  
  desc "Create the database, load the schema and seed all data"
  task :setup do
    ["rake:db:create", "db:migrate", "db:seed", "batch:related_media:sync", "batch:import:seed"].each do |task|
      Rake::Task[task].invoke
      Rake::Task[task].reenable
    end
  end

end

namespace :batch do

  namespace :import do

    # bundle exec rake batch:import:api
    desc "Import records via remote api connection"
    task :api, [:record_type, :path, :key, :since] => :environment do |t, args|
      log         = ActiveSupport::Logger.new('log/batch_import_api.log')
      record_type = args[:record_type] || 'CollectionObject'
      klass       = record_type.camelize.constantize
      rtype       = record_type.downcase
      path        = args[:path]  || "collectionobjects"
      key         = args[:key]   || "object_number"
      since       = args[:since] || Date.yesterday

      attribute_map = AttributeMap.where(record_type: rtype).as_json
      # TODO: abort if attribute map not found

      search_args = {
        path: "#{path}",
        type: "collectionspace_core",
        field: 'updatedAt',
        expression: ">= TIMESTAMP '#{since}T00:00:00'",
      }
      query = CollectionSpace::Search.new.from_hash search_args
      # TODO: check search result status first.

      start_time = Time.now
      puts_and_log log, "Import for #{path} updated since #{since} started at #{start_time}"

      COLLECTIONSPACE_CLIENT.search_all(query) do |item|
        record     = COLLECTIONSPACE_CLIENT.get(item["uri"]).parsed
        attributes = COLLECTIONSPACE_CLIENT.to_object(record, attribute_map)

        # create or update object
        object = klass.where(key.to_sym => attributes[key]).first

        if object
          object.update(attributes)
          puts_and_log log, "Updated:\t#{attributes[key]}"
        else
          klass.create(attributes)
          object = klass.where(key.to_sym => attributes[key]).first
          puts_and_log log, "Created:\t#{attributes[key]}"
        end

        # PROCESS RELATED MEDIA
        related = Relationship.where(subject_uri: attributes["uri"]).first
        if related and object.respond_to?(:thumbnail) and !object.thumbnail.exists?
          blob_url = "#{related[:object_uri]}/blob"
          if COLLECTIONSPACE_CLIENT.get(blob_url).status_code == 200
            object.blob_url = blob_url
            thumbnail = COLLECTIONSPACE_CLIENT.get("#{blob_url}/derivatives/Thumbnail/content")
            tmp_file  = Tempfile.new [ "#{attributes[key]}-", ".#{thumbnail.headers["content-type"].split("/")[1]}" ]
            tmp_file.binmode
            tmp_file.write thumbnail.body
            tmp_file.rewind
            object.thumbnail = tmp_file
            tmp_file.unlink
            puts_and_log log, "Thumbnail:\t#{attributes[key]}"
          end
        end
        object.save
      end

      end_time = Time.now
      duration = (start_time - end_time) / 1.minute
      puts_and_log log, "Import finished at #{end_time} and lasted for #{duration} minutes."
      log.close
    end

    # bundle exec rake batch:import:csv[records.csv]
    desc "Import records via csv dump"
    task :csv, [:csv] => :environment do
      puts "TODO"
    end

    # bundle exec rake batch:import:seed
    desc "Seed records via remote api connection"
    task :seed => :environment do
      Rake::Task["batch:import:api"].invoke('CollectionObject', 'collectionobjects', 'object_number', '1900-01-01')
      Rake::Task["batch:import:api"].reenable
    end

  end

  namespace :related_media do
    
    relation_options = { query: { sbjType: "CollectionObject", objType: "Media", wf_deleted: "false" } }

    # bundle exec rake batch:related_media:sync
    desc "Import collectionobject and media relationships data"
    task :sync => :environment do
      log = ActiveSupport::Logger.new('log/related_media_sync.log')
      # Blow away all existing relationship data
      Relationship.delete_all
      ActiveRecord::Base.connection.reset_pk_sequence!('relationships')
      attribute_map = AttributeMap.where(record_type: 'relationship').as_json

      COLLECTIONSPACE_CLIENT.all('relations', relation_options) do |record|
        attributes = {}
        attribute_map.each do |map|
          attributes[map["field"]] = record[map["key"]][map["nested_key"]]
        end
        Relationship.create attributes
        puts_and_log log, "Created:\t#{attributes['subject_type']} (#{attributes['subject_csid']}) #{attributes['object_type']} (#{attributes['object_csid']})"
      end
    end

  end

end
