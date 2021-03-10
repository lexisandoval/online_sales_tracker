class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.integer :shop_id
      
      t.timestamps null: false
    end
  end
end
