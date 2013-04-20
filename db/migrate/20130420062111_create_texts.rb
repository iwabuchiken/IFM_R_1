class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :text
      t.string :title
      t.string :word_ids
      t.string :url
      t.integer :genre_id
      t.integer :subgenre_id
      t.integer :lang_id
      t.text :memo
      t.integer :dbId

      t.timestamps
    end
  end
end
