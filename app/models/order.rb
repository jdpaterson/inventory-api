class Order < ApplicationRecord
  has_many :inventory_orders, dependent: :destroy
  has_many :inventories, through: :inventory_orders

  enum order_status: [:processing, :cancelled, :complete]

  accepts_nested_attributes_for :inventory_orders #, reject_if: proc { |attr| Inventory.where(id: 1).blank? }


  validate :has_enough_inventory, if: -> { order_status == "processing" }
  # validates_associated :inventory_orders

  before_create :set_purchase_date


  private

  def attributes
    super.merge({ 'inventory_orders' => inventory_orders })
  end

  # Calculate total amounts per inventory taking into account if
  # an inventory is specified multiple times on a single order
  def has_enough_inventory
    inventory_amounts = self.inventory_orders.reduce({}) do |inv_amounts, inv_ord|
      inv_amounts[inv_ord.inventory_id].present? ?
      inv_amounts[inv_ord.inventory_id] += inv_ord.order_quantity :
      inv_amounts[inv_ord.inventory_id] = inv_ord.order_quantity
      inv_amounts
    end
    has_insufficient_amount = inventory_amounts.any? do |inv_id, amount|
      Inventory.find(inv_id).quantity_available < amount
    end
    if has_insufficient_amount
      errors.add(:order_amount, "exceeds available inventory")
    end
  end

  def set_purchase_date
    self.date_order_placed = Time.now
  end
end
