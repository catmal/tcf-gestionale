class SalesOrder < Order
  has_many :sales_order_lines, class_name: 'SalesOrderLine', foreign_key: 'order_id', dependent: :destroy
  has_many :purchase_orders, as: :sourceable
end
