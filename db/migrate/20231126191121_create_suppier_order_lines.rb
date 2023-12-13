class CreateSuppierOrderLines < ActiveRecord::Migration[7.1]
  def change
    create_table :supplier_order_lines do |t|
      t.references :supplier_order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
