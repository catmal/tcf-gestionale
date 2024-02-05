# supplier_order_manager.rb
module SupplierOrders
  class ComponentAdder
    attr_reader :bill_of_material_line, :bill_of_material

    def initialize(bill_of_material_line, session, flash)
      @bill_of_material_line = bill_of_material_line
      @bill_of_material = bill_of_material_line.bill_of_material
      @session = session
      @flash = flash
    end

    def add_component_to_supplier_order
      update_supplier_order
      update_buttons
    end

    private

    def update_supplier_order
      supplier_order_lines = @session["supplier_order_#{bill_of_material.id}_supplier_order_lines"]
      existing_line = supplier_order_lines.find { |line| line[:code] == bill_of_material_line.component.code }

      if supplier_order_lines.present? && existing_line.present?
        existing_line[:quantity] += 1 if existing_line[:quantity] < bill_of_material_line.quantity
        existing_line[:to_order] -= 0 if bill_of_material_line.to_order > 0

      else
        supplier_order_lines.push(
          item_id: bill_of_material_line.component.id,
          quantity: 1,
          ordered: bill_of_material_line.ordered,
          to_order: bill_of_material_line.to_order - 1,
          name: bill_of_material_line.component.name,
          code: bill_of_material_line.component.code
        )
      end
    end

    def update_buttons
      session_buttons = @session["bill_of_material_#{@bill_of_material.id}_bill_of_material_lines"]
      button = session_buttons
               .find { |line| line.component.code == bill_of_material_line.component.code }
      return unless button.present? && button[:quantity].to_i.positive?

      button[:quantity] -= 1
      @flash[:notice] =
        "Componente #{bill_of_material_line.component.code} #{bill_of_material_line.component.name} aggiunto all'ordine!"
    end
  end
end
