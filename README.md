# README

Hi, thanks for having a look at this inventory-api built on Ruby on Rails 6.
This API supports CRUD operations for Order and Inventory REST endpoints.

Installation instructions and endpoint notes are below.

## Installation:

Dependencies:

- Ruby
- Bundler

Steps to run:

- Clone and download repository

Run the following from app root directory:

- `bundle install`
- `rails db:create`
- `rails db:migrate`
- `rails db:seed`

To run the server: `rails s`
To run tests: `rails test`

Make requests to: `http://localhost:3000/`

## Endpoint Notes:

Most endpoints will work as you would expect from a RESTful API. Of note is the `inventory_orders_attributes` attribute of an Order, which allows you to update inventories of an order. A call using this looks like:

```
 <!-- Creates an order of 10 items of inventory 1 -->
POST /orders
{
	"customer_email_address": "inventory@api.com",
	"inventory_orders_attributes": [
		{
			"inventory_id": 1,
			"order_quantity": 10
		}
	]
}
```

The other feature of note is the way that inventories maintain their available quantity. This is done through a "supplies" table. To increase the available amount of an inventory, add a supply. A call using this feature looks like:

```
  <!-- Increases the available quantity of inventory 1 by 10 -->
  PUT/PATCH /inventories/1
  {
    supplies_attributes: [
      {
        supplied_amount: 10
      }
    ]
  }
```

Anything else I can provide please let me know
contact@jpatersondev.com
