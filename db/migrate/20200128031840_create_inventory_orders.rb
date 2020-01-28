class CreateInventoryOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_orders do |t|
      t.references :inventory, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
