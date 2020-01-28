class Order < ApplicationRecord
  has_many :inventory_orders
  has_many :inventories, through: :inventory_orders

  enum order_status: [:processing, :complete, :cancelled]

  accepts_nested_attributes_for :inventory_orders
end
