class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.string :name
      t.text :description
      t.float :price

      t.timestamps
    end
  end
end
