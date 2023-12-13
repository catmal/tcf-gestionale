class BillOfMaterial < ApplicationRecord
  # Associations
  has_many :bill_of_material_lines, dependent: :destroy
  has_many :components, through: :bill_of_material_lines
  has_many :groups, through: :bill_of_material_lines
  has_many :supplier_orders, dependent: :destroy
  auto_increment :number, initial: "DIS-#{Date.today.year}-0001"

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

  # Validations
  validates :some_field, presence: true
  # Add other validations as needed
end
