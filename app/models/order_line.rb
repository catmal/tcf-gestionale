class OrderLine < ApplicationRecord
  belongs_to :order, inverse_of: :order_lines
  belongs_to :item
  has_one :order_line_quantity, dependent: :destroy

  after_save :update_ordered_quantities

  def update_ordered_quantities
    return unless order.is_a?(PurchaseOrder) && order.sourceable.is_a?(SalesOrder)

    line = order.sourceable.order_lines.find_by(item_id:)
    quantities = line.order_line_quantity

    quantities.update!(ordered: quantities.ordered + 1)
    quantities.update!(to_order: quantities.to_order - 1)
  end
end
