require 'faker'

inventories = (1..5).map do
  {
    name: Faker::Cannabis.brand,
    description: "#{Faker::Cannabis.cannabinoid} | #{Faker::Cannabis.type} | #{Faker::Cannabis.health_benefit}",
    price: Faker::Number.decimal(l_digits: 2),
    supplies_attributes: [
      {
        supplied_amount: 100
      }
    ]
  }
end
Inventory.create(inventories)

orders = [
  {
    customer_email_address: Faker::Internet.email,
    date_order_placed: Faker::Date.in_date_period,
    inventory_orders_attributes: [
      {
        inventory: Inventory.first,
        order_quantity: 25
      },
      {
        inventory: Inventory.second,
        order_quantity: 50
      },
      {
        inventory: Inventory.third,
        order_quantity: 75
      }
    ]
  },
  {
    customer_email_address: Faker::Internet.email,
    date_order_placed: Faker::Date.in_date_period,
    inventory_orders_attributes: [
      {
        inventory: Inventory.first,
        order_quantity: 30
      },
      {
        inventory: Inventory.second,
        order_quantity: 25
      },
      {
        inventory: Inventory.third,
        order_quantity: 10
      }
    ]
  }
]

Order.create(orders)