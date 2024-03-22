class SalesOrder < Order
  has_many :sales_order_lines, class_name: 'SalesOrderLine', foreign_key: 'order_id', dependent: :destroy
  has_many :purchase_orders, as: :sourceable
  auto_increment :number, initial: "OC-#{Date.today.year}-0001"
end
