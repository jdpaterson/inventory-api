require 'test_helper'

class SuppliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @low_supply = supplies(:low_supply)
  end

  test "should get index" do
    get supplies_url, as: :json
    assert_response :success
  end

  test "should create supply" do
    assert_difference('Supply.count') do
      post supplies_url, params: {
        supply: {
          inventory_id: @low_supply.inventory_id,
          supplied_amount: @low_supply.supplied_amount
        }
      }, as: :json
    end

    assert_response 201
  end

  test "should show supply" do
    get supply_url(@low_supply), as: :json
    assert_response :success
  end

  test "should update supply" do
    patch supply_url(@low_supply), params: {
      supply: {
        inventory_id: @low_supply.inventory_id,
        supplied_amount: @low_supply.supplied_amount
      }
    }, as: :json
    assert_response 200
  end

  test "should destroy supply" do
    assert_difference('Supply.count', -1) do
      delete supply_url(@low_supply), as: :json
    end

    assert_response 204
  end
end
