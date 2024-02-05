class BillOfMaterial < ApplicationRecord
  # Associations
  has_many :bill_of_material_lines, dependent: :destroy
  has_many :components, through: :bill_of_material_lines
  has_many :groups, through: :bill_of_material_lines
  has_many :supplier_orders, dependent: :destroy
  has_many :sales_orders, as: :sourceable
  auto_increment :number, initial: "DIS-#{Date.today.year}-0001"
  has_many :supplier_order_lines, through: :supplier_orders
  # Class Methods

  # Instance Methods

  # CSV generation for components
  def components_to_csv
    csv_data = CSV.generate(col_sep: ';', encoding: 'utf-8', quote_char: '"', headers: true) do |csv|
      csv << %w[ARTICOLO DESCRIZIONE]
      components.distinct.each do |item|
        csv << [item.code, item.name]
      end
    end
    csv_data.encode('windows-1252')
  end

  # CSV generation for purchase order groups
  def purchase_order_groups_to_csv
    csv_data = CSV.generate(col_sep: ';', encoding: 'utf-8', quote_char: '"', headers: true) do |csv|
      csv << %w[ARTICOLO DESCRIZIONE]
      groups.distinct.each do |group|
        csv << [group.code, group.name]
      end
    end
    csv_data.encode('windows-1252')
  end

  def create_sales_order
    sales_order = SalesOrder.create(date:, sourceable: self, sendable: Company.find_by(name: 'IMA'),
                                    receivable: Company.find_by(name: 'TCF'))

    bill_of_material_lines.group(:component_id).sum(:quantity).each do |component_id, quantity|
      order_line = OrderLine.create!(item_id: component_id, order: sales_order, quantity:)
      OrderLineQuantity.create(order_line:, total: quantity, ordered: 0, to_order: quantity)
    end
  end

  # Validations
  # Add other validations as needed
end
