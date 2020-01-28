class Inventory < ApplicationRecord
  has_many :orders
  has_many :supplies
end
