class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @invoiceitems = InvoiceItem.where(invoice_id: @invoice.id)
  end
end