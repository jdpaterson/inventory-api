class Order < ApplicationRecord
  has_many :inventory_orders
  has_many :inventories, through: :inventory_orders

  enum order_status: [:processing, :complete, :cancelled]

  accepts_nested_attributes_for :inventory_orders

  validate :has_enough_inventory

  # TODO: Clean this up
  def has_enough_inventory
    # Calculate total amounts per inventory taking into account if
    # an inventory is specified multiple times on a single orderrails test test/integration/order_placement_test.rb:48
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
      errors.add(:order_amount, " exceeds available inventory")
    end
  end
end
