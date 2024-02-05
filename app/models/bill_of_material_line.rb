class BillOfMaterialLine < ApplicationRecord
  belongs_to :bill_of_material
  belongs_to :component
  belongs_to :group
  has_many :supplier_order_lines, foreign_key: 'item_id', primary_key: 'component_id'
end
