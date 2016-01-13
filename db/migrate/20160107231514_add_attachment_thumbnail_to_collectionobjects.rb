class AddAttachmentThumbnailToCollectionobjects < ActiveRecord::Migration
  def self.up
    change_table :collection_objects do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :collection_objects, :thumbnail
  end
end
