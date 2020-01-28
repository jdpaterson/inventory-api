class CreateSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :supplies do |t|
      t.references :inventory, null: false, foreign_key: true
      t.integer :supplied_amount

      t.timestamps
    end
  end
end
