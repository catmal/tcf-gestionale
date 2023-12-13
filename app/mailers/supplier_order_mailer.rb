class SupplierOrderMailer < ApplicationMailer
  def new_supplier_order_email
    @supplier_order = params[:supplier_order]

    mail(to: @supplier_order.supplier.email, subject: 'Nuovo Ordine da TCF')
  end
end
