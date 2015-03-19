class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :admin_user
      t.string :admin_email

      t.timestamps
    end
  end
end
