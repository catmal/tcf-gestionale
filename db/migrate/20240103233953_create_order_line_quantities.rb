class CreateOrderLineQuantities < ActiveRecord::Migration[7.1]
  def change
    create_table :order_line_quantities do |t|
      t.references :order_line, null: false, foreign_key: true
      t.decimal :ordered
      t.decimal :to_order
      t.decimal :total

      t.timestamps
    end
  end
end
