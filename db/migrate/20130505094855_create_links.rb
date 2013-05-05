class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.text :memo
      t.integer :created_at_mill
      t.integer :updated_at_mill

      t.timestamps
    end
  end
end
