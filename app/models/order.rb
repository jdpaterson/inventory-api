class Order < ApplicationRecord
  has_many :inventory_orders
  has_many :inventories, through: :inventory_orders

  enum order_status: [:cancelled, :complete]
end
