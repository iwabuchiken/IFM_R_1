class CreateLangs < ActiveRecord::Migration
  def change
    create_table :langs do |t|
      t.string :name
      t.integer :created_at_mill, :limit => 8, :default => 0, :null => false
      t.integer :updated_at_mill, :limit => 8, :default => 0, :null => false

      t.timestamps
    end
  end
end
