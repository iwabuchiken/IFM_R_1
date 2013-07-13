class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :text
      t.string :title
      t.string :word_ids
      t.string :url
      t.integer :genre_id, :default => 0, :null => false
      t.integer :subgenre_id, :default => 0, :null => false
      t.integer :lang_id, :default => 0, :null => false
      t.text :memo
      t.integer :dbId, :default => 0, :null => false
      # t.integer :created_at_mill, :default => 0, :null => false
      # t.bigint :created_at_mill, :default => 0, :null => false
      
      # => http://stackoverflow.com/questions/1066340/how-to-use-long-id-in-rails-applications
      t.integer :created_at_mill, :limit => 8, :default => 0, :null => false
      t.integer :updated_at_mill, :limit => 8, :default => 0, :null => false

      t.timestamps
    end
  end
end
