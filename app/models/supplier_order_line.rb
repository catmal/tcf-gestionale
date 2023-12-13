class SupplierOrderLine < ApplicationRecord
  belongs_to :supplier_order
  belongs_to :item
end
