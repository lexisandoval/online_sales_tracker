class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.string :title
      t.float :amount
      t.integer :user_id
      t.timestamps null: false
    end
  end
end