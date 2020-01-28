class Order < ApplicationRecord
  has_many :inventory_orders
  has_many :inventories, through: :inventory_orders

  accepts_nested_attributes_for :inventory_orders
end
