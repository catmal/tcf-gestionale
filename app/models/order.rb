class Order < ApplicationRecord
  belongs_to :sourceable, optional: true, polymorphic: true
  belongs_to :sendable, polymorphic: true
  belongs_to :receivable, polymorphic: true
  has_many :order_lines, dependent: :destroy
  has_many :items, through: :order_lines

  enum type: {
    PurchaseOrder: 1,
    SalesOrder: 2,
    DeliveryOrder: 3,
    ReturnOrder: 4

  }

  def update_quantities_on_destroy_purchase_order
    return unless is_a?(PurchaseOrder) && sourceable.is_a?(SalesOrder)

    line = order.sourceable.order_lines.find_by(item_id:)
    quantities = line.order_line_quantity

    quantities.update!(ordered: quantities.ordered + 1)
    quantities.update!(to_order: quantities.to_order - 1)
  end
end
