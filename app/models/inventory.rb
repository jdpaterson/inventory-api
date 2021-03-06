class Inventory < ApplicationRecord
  attr_reader :quantity_available
  has_many :inventory_orders
  has_many :orders, through: :inventory_orders
  has_many :supplies, dependent: :destroy
  accepts_nested_attributes_for :supplies

  def quantity_available
    supplies.sum(:supplied_amount) - inventory_orders.active.sum(:order_quantity)
  end

  private
  def attributes
    super.merge({ 'quantity_available' => quantity_available })
  end

end
