class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :files_per_page

      t.timestamps
    end
  end
end
