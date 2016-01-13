class CollectionObject < ActiveRecord::Base
  include PgSearch
  extend FriendlyId

  friendly_id :slug_object_number, use: [:slugged, :finders]
  has_attached_file :thumbnail, default_url: '/images/:style/placeholder.png'
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
    result  = COLLECTIONSPACE_CLIENT.get(uri)
    updated = false
    if result.status_code == 200
      attribute_map = AttributeMap.where(record_type: 'collectionobject')
      record        = result.parsed
      attributes    = COLLECTIONSPACE_CLIENT.to_object(record, attribute_map)
      updated       = attributes['updated_at'] > updated_at
    else
      raise "Error connecting to backend for #{uri}"
    end
    updated
  end

  def has_remote_image?
    thumbnail.exists?
  end

  def remote_image
    raise "Record has no associated media." unless has_remote_image?
    Rails.cache.fetch("#{cache_key}/remote_image", expires_in: 24.hours) do
      Base64.encode64(COLLECTIONSPACE_CLIENT.get("#{blob_url}/derivatives/Small/content").body)
    end
  end

  def slug_object_number
    object_number.gsub(/\./, '-')
  end
end
