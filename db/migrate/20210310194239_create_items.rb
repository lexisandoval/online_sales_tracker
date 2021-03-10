class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :type 
      t.float :amount
      t.integer :sale_id
      t.timestamps null: false
    end
  end
end
