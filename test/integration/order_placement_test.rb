require 'test_helper'

class OrderPlacementTest < ActionDispatch::IntegrationTest
  setup do
    @basic_order_1 = orders(:basic_order_1)
    @high_inventory = inventories(:high_inventory)
    @low_inventory = inventories(:low_inventory)
  end

  test "when creating an order, inventory should be updated accordingly" do
    original_quantity = @high_inventory.quantity_available
    post  orders_url,
          params: {
            order: {
              customer_email_address: @basic_order_1.customer_email_address,
              inventory_orders_attributes: [
                inventory_id: inventories(:high_inventory).id,
                order_quantity: 10
              ]
            }
          },
          as: :json
      assert_equal(
        Inventory.find(@high_inventory.id).quantity_available,
        original_quantity - 10
      )
  end

  test "when updating an order, inventory should be updated accordingly" do
    original_quantity = @high_inventory.quantity_available
    put order_url(@basic_order_1),
        params: {
          order: {
            customer_email_address: @basic_order_1.customer_email_address,
            inventory_orders_attributes: [
              inventory_id: inventories(:high_inventory).id,
              order_quantity: 10
            ]
          }
        },
        as: :json
    assert_equal(
      Inventory.find(@high_inventory.id).quantity_available,
      original_quantity - 10
    )
  end

  test "when cancelling an order, inventory should be updated accordingly" do
    original_quantity = @high_inventory.quantity_available
    put order_url(@basic_order_1),
        params: {
          order: {
            order_status: "cancelled"
          }
        },
        as: :json
    assert_equal(
      Inventory.find(@high_inventory.id).quantity_available,
      original_quantity + 10
    )
  end

  test "if order quantity exceeds available inventory, get an error" do
    post  orders_url,
          params: {
            order: {
              customer_email_address: @basic_order_1.customer_email_address,
              inventory_orders_attributes: [
                inventory_id: inventories(:low_inventory).id,
                order_quantity: 100
              ]
            }
          },
          as: :json
    assert_response 422
  end

end