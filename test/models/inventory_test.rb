require 'test_helper'

class InventoryTest < ActiveSupport::TestCase
  setup do
    @inventory = inventories(:two)
    @supply = supplies(:two)
    @order = orders(:two)
  end
  test "should have correct quantity available" do
    assert_equal @inventory.quantity_available, 75
  end
end
