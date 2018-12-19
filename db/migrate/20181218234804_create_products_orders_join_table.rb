class CreateProductsOrdersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :products, :orders do |t|
      t.integer :number_purchased, null: false
      t.index :product_id
      t.index :order_id
    end
  end
end
