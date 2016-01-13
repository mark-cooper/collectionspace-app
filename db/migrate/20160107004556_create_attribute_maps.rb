class CreateAttributeMaps < ActiveRecord::Migration
  def change
    create_table :attribute_maps do |t|
      t.string  :record_type, null: false
      t.string  :field, null: false
      t.string  :key, null: false
      t.string  :nested_key, null: false
      t.string  :with
      t.boolean :searchable, default: false

      t.timestamps null: false
    end
  end
end
