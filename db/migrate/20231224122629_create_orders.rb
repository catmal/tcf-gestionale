class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.date :date
      t.string :number
      t.references :sendable, polymorphic: true
      t.references :receivable, polymorphic: true
      t.references :sourceable, polymorphic: true
      t.integer :type

      t.timestamps
    end
  end
end
