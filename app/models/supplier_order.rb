class SupplierOrder < ApplicationRecord
  belongs_to :supplier
  belongs_to :bill_of_material
  has_many :supplier_order_lines, dependent: :destroy
  has_many :items, through: :supplier_order_lines
  auto_increment :number, initial: "ORD-FOR-#{Date.today.year}-0001"

  def add_component_to_order(bill_of_material_line)
    existing = supplier_order_lines.find_by(item_id: bill_of_material_line.component.id)

    if existing.present?
      existing.update(quantity: [existing.quantity + 1, bill_of_material_line.quantity].min)
    else
      supplier_order_lines.create!(
        item_id: bill_of_material_line.component.id,
        quantity: 1,
        name: bill_of_material_line.component.name,
        code: bill_of_material_line.component.code
      )
    end

    button = bill_of_material_lines.find { |line| line.component.code == bill_of_material_line.component.code }

    return unless button.present? && button.quantity.positive?

    button.update(quantity: button.quantity - 1)
  end
end
