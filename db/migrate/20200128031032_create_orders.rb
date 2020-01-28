class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :customer_email_address
      t.datetime :date_order_placed
      t.integer :order_status
      t.integer :order_quantity
      t.references :inventory, null: false, foreign_key: true
      t.timestamps
    end
  end
end
