class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = @merchants.where(status: "enabled")
    @disabled_merchants = @merchants.where(status: "disabled")
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])

    if params[:status]
      merchant.update(status: params[:status])
      redirect_to "/admin/merchants"
    else
      merchant.update(name: params[:name])
      flash.notice = "Merchant information has been updated"
      redirect_to "/admin/merchants/#{merchant.id}"
    end
    
  end
end
