module SupplierOrdersHelper
  def suppliers_for_select
    Manufacturer.all.collect { |m| [m.name] }
  end
end
