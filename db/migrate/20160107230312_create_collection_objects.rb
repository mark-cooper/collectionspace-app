class CreateCollectionObjects < ActiveRecord::Migration
  def change
    create_table :collection_objects do |t|
      t.string :object_number, null: false
      t.string :object_name
      t.string :responsible_department
      t.string :title
      t.string :title_type
      t.date :display_date
      t.text :brief_description
      t.string :content_persons, array: true, default: []
      t.string :content_concepts, array: true, default: []
      t.text :physical_description
      t.text :dimension_summary
      t.string :material_group, array: true, default: []
      t.string :technique_group, array: true, default: []
      t.string :object_production_organization_group, array: true, default: []
      t.string :object_production_people_group, array: true, default: []
      t.string :object_production_person_group, array: true, default: []
      t.string :ref_name, null: false
      t.string :uri, null: false
      t.string :created_by, null: false
      t.string :blob_url
      t.string :slug, unique: true

      t.timestamps null: false
    end
  end
end
