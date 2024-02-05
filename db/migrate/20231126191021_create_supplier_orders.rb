class CreateSupplierOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :supplier_orders do |t|
      t.string :number
      t.references :supplier, null: false, foreign_key: true
      t.date :date
      t.date :delivery_date
      t.references :bill_of_material, null: false, foreign_key: true
      t.string :machine

      t.timestamps
    end
  end
end
