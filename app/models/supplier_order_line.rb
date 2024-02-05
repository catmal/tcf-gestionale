class SupplierOrderLine < ApplicationRecord
  belongs_to :supplier_order
  belongs_to :item
  has_many :bill_of_material_lines, foreign_key: 'component_id', primary_key: 'item_id'
  validates :quantity, :item_id, presence: true
  validates_uniqueness_of :item_id, scope: :supplier_order_id

  def set_bill_of_material_lines
    ordered = bill_of_material_lines.currently_ordered
    to_order = bill_of_material_lines.quantity - ordered
    bill_of_material_line.update(ordered:, to_order:)
  end

  def total_quantity
    bill_of_material_lines.group(:component_id).sum(:quantity)[component_id]
  end

  def total_ordered
    bill_of_material_lines.group(:component_id).sum(:ordered)
  end

  def total_to_order
    total_quantity - total_ordered
  end
end
