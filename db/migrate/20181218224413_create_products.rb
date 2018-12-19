class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :weight, :precision => 15, :scale => 2
      t.references :category
      t.timestamps
    end
  end
end
