class CreateBillOfMaterialLines < ActiveRecord::Migration[7.1]
  def change
    create_table :bill_of_material_lines do |t|
      t.references :component, foreign_key: { to_table: 'items' }
      t.references :group, foreign_key: { to_table: 'items' }
      t.integer :quantity
      t.references :bill_of_material, null: false, foreign_key: true
      t.timestamps
    end
  end
end
