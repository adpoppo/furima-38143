class PurchasesController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @purchase_customer = PurchaseCustomer.new
  end

  def create
    @purchase_customer = PurchaseCustomer.new(purchase_customer_params)
    if @purchase_customer.valid?
      @purchase_customer.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end

  end

  private

    def purchase_customer_params
      params.require(:purchase_customer).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id].to_i)
    end

end
