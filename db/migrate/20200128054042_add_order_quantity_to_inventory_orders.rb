class AddOrderQuantityToInventoryOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :inventory_orders, :order_quantity, :integer
  end
end
