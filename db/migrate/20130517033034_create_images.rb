class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file_name
      t.string :file_path
      t.text :memos
      t.string :tags
      t.string :table_name
      t.integer :last_viewed_at
      t.integer :created_at_mill
      t.integer :updated_at_mill
      t.integer :date_added
      t.integer :date_modified
      t.integer :loc_file_id
      t.integer :loc_created_at
      t.integer :loc_modified_at

      t.timestamps
    end
  end
end
