class PurchaseOrder < Order
  auto_increment :number, initial: "OF-#{Date.today.year}-0001"
  has_many :purchase_order_lines, class_name: 'SalesOrderLine', foreign_key: 'order_id', dependent: :destroy

  def add_component_to_order(sales_order_line)
    PurchaseOrderLine.create!(item_id: sales_order_line.item_id, order_id: id,
                              quantity: sales_order_line.quantity)
  end
end
