class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
	  t.integer :number_of_purchased, null: false
	  t.references :order
	  t.references :product
	  
      t.timestamps
    end
  end
end
