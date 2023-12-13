class Group < Item
  def group_to_csv(bill_of_material_lines)
    csv_data = CSV.generate(col_sep: ';') do |csv|
      csv << %w[ARTICOLO DESCRIZIONE NUMERO]
      children.each do |item|
        bill_of_material_line = bill_of_material_lines.where(component_id: item.id).find_by(group_id: id)
        csv << [item.code, item.name, bill_of_material_line.quantity.to_i]
      end
    end
    csv_data.encode('windows-1252')
  end
end
