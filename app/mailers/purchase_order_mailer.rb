class PurchaseOrderMailer < ApplicationMailer
  def new_purchase_order_email
    @purchase_order = params[:purchase_order]

    mail(to: @purchase_order.receivable.email, subject: 'Nuovo Ordine da TCF')
  end
end
