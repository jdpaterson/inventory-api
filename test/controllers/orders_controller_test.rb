require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basic_order_1 = orders(:basic_order_1)
    @empty_order_1 = orders(:empty_order_1)
  end

  test "should get index" do
    get orders_url, as: :json
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: {
        order: {
          customer_email_address: @basic_order_1.customer_email_address,
          inventory_orders: [
            inventory_id: inventories(:high_inventory),
            order_quantity: 10
          ]
        }
      }, as: :json
    end

    assert_response 201
  end

  test "should show order" do
    get order_url(@basic_order_1), as: :json
    assert_response :success
  end

  test "should update order" do
    patch order_url(@basic_order_1), params: {
      order: {
        customer_email_address: @basic_order_1.customer_email_address,
        date_order_placed: @basic_order_1.date_order_placed,
        order_status: @basic_order_1.order_status
      }
    }, as: :json
    assert_response 200
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@empty_order_1), as: :json
    end

    assert_response 204
  end
end
