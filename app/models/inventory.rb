class Inventory < ApplicationRecord
  attr_reader :quantity_available
  has_many :orders
  has_many :supplies

  def attributes
    super.merge({ 'quantity_available' => quantity_available })
  end

  def quantity_available
    supplies.sum(:supplied_amount) - orders.sum(:order_quantity)
  end

end
