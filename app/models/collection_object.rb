class CollectionObject < ActiveRecord::Base
  include PgSearch
  extend FriendlyId

  before_save :set_title
  paginates_per 10

  friendly_id :slug_object_number, use: [:slugged, :finders]
  has_attached_file :thumbnail, default_url: Rails.application.config.paperclip_default_url
  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\Z/

  pg_search_scope(
    :search,
    against: AttributeMap.where(record_type: 'collectionobject', searchable: true).pluck(:field).map(&:to_sym),
    using: { tsearch: { dictionary: 'english' } }
  )

  pg_search_scope(
    :advanced_search,
    ->(field, query) { 
      return { 
        against: field,
        using: { tsearch: { dictionary: 'english' } },
        query: query
      }
    }
  )

  def has_been_updated?
    attributes = remote_metadata_attributes
    updated    = attributes['origin_updated_at'] > origin_updated_at ? true : false
    updated
  end

  def has_remote_image?
    thumbnail.exists?
  end

  def remote_image(size = :small)
    raise "Record has no associated media." unless has_remote_image?
    size = size.to_s.capitalize
    begin
      Rails.cache.fetch("#{cache_key}/remote_image/#{size}", expires_in: 24.hours) do
        Base64.encode64(COLLECTIONSPACE_CLIENT.get("#{blob_url}/derivatives/#{size}/content").body)
      end
    rescue
      Rails.cache.fetch("#{cache_key}/remote_image/placeholder") do
        path = Rails.public_path.join(Rails.application.config.paperclip_small_placeholder_path)
        Base64.encode64( File.read(path) )
      end
    end
  end

  def remote_metadata
    Rails.cache.fetch("#{cache_key}/remote_metadata", expires_in: 30.seconds) do
      COLLECTIONSPACE_CLIENT.get(uri).parsed
    end
  end

  def remote_metadata_attributes
    metadata      = remote_metadata
    attribute_map = AttributeMap.where(record_type: 'collectionobject')
    attributes    = COLLECTIONSPACE_CLIENT.to_object(metadata, attribute_map)
    attributes
  end

  def slug_object_number
    object_number.gsub(/\./, '-')
  end

  private

  def set_title
    self.title ||= "Untitled"
  end
end
