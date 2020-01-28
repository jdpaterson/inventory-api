require 'test_helper'

class InventoryTest < ActiveSupport::TestCase
  setup do
    @inventory = inventories(:high_inventory)
  end
  test "should have correct quantity available" do
    assert_equal @inventory.quantity_available, 65
  end
end
