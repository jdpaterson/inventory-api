class InventoryOrder < ApplicationRecord
  belongs_to :inventory
  belongs_to :order
  scope :active, -> () { joins(:order).where.not(orders: { order_status: 'cancelled' }) }
end
