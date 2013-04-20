class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :w1
      t.string :w2
      t.string :w3
      t.string :text_ids
      t.integer :text_id, :default => 0, :null => false
      t.integer :lang_id, :default => 0, :null => false
      t.integer :dbId, :default => 0, :null => false
      t.integer :created_at_mill, :default => 0, :null => false

      t.timestamps
    end
  end
end
