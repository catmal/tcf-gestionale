# Preview all emails at http://localhost:3000/rails/mailers/supplier_supplier_order_mailer
class SupplierOrderMailerPreview < ActionMailer::Preview
  def new_supplier_supplier_order_email
    # Set up a temporary supplier_order for the preview
    supplier_order = SupplierOrder.first

    SupplierOrderMailer.with(supplier_order:).new_supplier_order_email
  end
end
