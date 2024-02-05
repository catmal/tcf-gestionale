class PurchaseOrder < Order
  auto_increment :number, initial: "OF-#{Date.today.year}-0001"
  has_many :purchase_order_lines, class_name: 'SalesOrderLine', foreign_key: 'order_id', dependent: :destroy

  def add_component_to_order(sales_order_line, existing)
    order_line = if existing.present?
                   existing.update(quantity: existing.quantity + 1)
                   existing
                 else
                   purchase_order_line = PurchaseOrderLine.create!(item_id: sales_order_line.item_id, order_id: id,
                                                                   quantity: 1)
                   OrderLineQuantity.create!(total: 1, order_line: purchase_order_line)
                   purchase_order_line
                 end
    order_line.update_ordered_quantities
    order_line
  end

  # def update_quantities_on_destroy_purchase_order
  #   return unless sourceable.present? && sourceable.is_a?(SalesOrder)

  #   lines = sourceable.order_lines
  #   lines.each do |line|
  #     quantities = line.order_line_quantity
  #     quantities.update!(ordered: quantities.ordered + 1)
  #     quantities.update!(to_order: quantities.to_order - 1)
  #   end
  # end
end
