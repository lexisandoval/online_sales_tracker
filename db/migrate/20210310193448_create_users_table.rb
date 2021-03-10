class CreateUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |col|
      col.string :name
      col.string :email
      col.string :password_digest #encrypted password
    end
  end
end
