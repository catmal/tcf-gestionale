class CreateOrderedQuantities < ActiveRecord::Migration[7.1]
  def change
    create_table :ordered_quantities do |t|
      t.references :order, null: false, foreign_key: true
      t.decimal :ordered
      t.string :to

      t.timestamps
    end
  end
end
