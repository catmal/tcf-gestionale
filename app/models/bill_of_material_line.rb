class BillOfMaterialLine < ApplicationRecord
  belongs_to :bill_of_material
  belongs_to :component
  belongs_to :group
end
