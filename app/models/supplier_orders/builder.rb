# session_initializer.rb
module SupplierOrders
  class Builder
    def initialize(bill_of_material)
      @bill_of_material = bill_of_material
    end

    def initialize_session_variables(session)
      session_buttons = "bill_of_material_#{@bill_of_material.id}_bill_of_material_lines"
      session_sales_order_lines = "supplier_order_#{@bill_of_material.id}_supplier_order_lines"

      session[session_buttons] ||= []

      if session[session_buttons].empty?
        session[session_buttons] =
          @bill_of_material.bill_of_material_lines.includes([:component])
      end

      session[session_sales_order_lines] ||= []
    end
  end
end
