# Preview all emails at http://localhost:3000/rails/mailers/supplier_supplier_order_mailer
class PurchaseOrderMailerPreview < ActionMailer::Preview
  def new_purchase_order_email
    # Set up a temporary supplier_order for the preview

    PurchaseOrderMailer.with(supplier_order: @supplier_order).new_purchase_order_email
  end
end
