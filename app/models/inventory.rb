class Inventory < ApplicationRecord
  has_many :inventory_orders
  has_many :orders, through: :inventory_orders
  has_many :supplies
end
