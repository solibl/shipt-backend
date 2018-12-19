class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :status
      t.references :customer
      t.timestamps
    end
  end
end
