class SupplierOrder < ApplicationRecord
  belongs_to :supplier
  belongs_to :bill_of_material
  has_many :supplier_order_lines, dependent: :destroy
  has_many :items, through: :supplier_order_lines
  auto_increment :number, initial: "ORD-FOR-#{Date.today.year}-0001"
end
