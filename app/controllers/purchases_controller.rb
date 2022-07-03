class PurchasesController < ApplicationController

  def index
    @item = Item.find(params[:item.id])
    @purchase_customer = PurchaseCustomer.new
  end

end
