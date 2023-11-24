class BillOfMaterial < ApplicationRecord
  has_many :bill_of_material_lines, dependent: :destroy
  has_many :components, through: :bill_of_material_lines
  has_many :groups, through: :bill_of_material_lines

  def components_to_csv
    CSV.generate do |csv|
      components.each do |item|
        csv << [item.code, item.name]
      end
    end
  end

  def groups_to_csv
    CSV.generate do |csv|
      components.each do |item|
        csv << [item.parents.first.code, item.code, item.name]
      end
    end
  end
end
