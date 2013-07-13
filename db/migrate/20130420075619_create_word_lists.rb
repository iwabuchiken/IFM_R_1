class CreateWordLists < ActiveRecord::Migration
  def change
    create_table :word_lists do |t|
      t.integer :text_id, :default => 0, :null => false
      t.integer :word_id, :default => 0, :null => false
      t.integer :lang_id, :default => 0, :null => false
      t.integer :db_id, :default => 0, :null => false
      # t.integer :created_at_mill, :default => 0, :null => false
      t.integer :created_at_mill, :limit => 8, :default => 0, :null => false
      t.integer :updated_at_mill, :limit => 8, :default => 0, :null => false

      t.timestamps
    end
  end
end
