class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :subject_csid, null: false
      t.string :subject_type, null: false
      t.string :subject_uri, null: false
      t.string :object_csid, null: false
      t.string :object_type, null: false
      t.string :object_uri, null: false

      t.timestamps null: false
    end
  end
end
