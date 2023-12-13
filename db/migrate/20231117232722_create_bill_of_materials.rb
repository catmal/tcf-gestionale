class CreateBillOfMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :bill_of_materials do |t|
      t.date :date
      t.string :number
      t.string :purchase_order_url
      t.timestamps
    end
  end
end
