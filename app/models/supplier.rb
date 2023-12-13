class Supplier < ApplicationRecord
  has_many :supplier_orders, dependent: :destroy
end
