# app/services/import_processor.rb

module BillOfMaterials
  class Importer
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def process
      xlsx = Roo::Spreadsheet.open(file, extension: :xlsx)
      count = xlsx.count

      (2...count).each do |i|
        group_code = xlsx.row(i)[0]
        code = xlsx.row(i)[1]
        name = xlsx.row(i)[2]
        component_quantity = (xlsx.row(i)[3]).to_i if xlsx.row(i)[3].present?
        existing = Item.find_by(code:)&.created_at

        bill_of_material_line = { code:, name:, component_quantity:, group_code:,
                                  type: 'Component', existing: }
        group = { code: group_code, type: 'Group' }

        session[:groups].push(group) if group_code.present? && name.present? && !session[:groups].include?(group)
        session[:bill_of_material_lines].push(bill_of_material_line) if name.present?
      end

      session
    end
  end
end
