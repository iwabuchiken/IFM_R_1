class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :files_per_page

      t.timestamps
    end
  end
end
