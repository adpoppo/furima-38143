class PurchasesController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @purchase_customer = PurchaseCustomer.new
  end

  def create
    @purchase_customer = PurchaseCustomer.new(purchase_customer_params)
    if @purchase_customer.valid?
      pay_item
      @purchase_customer.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end

  end

  private

  def purchase_customer_params
    params.require(:purchase_customer).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id].to_i)
  end

  def pay_item
    Payjp.api_key = "sk_test_bc3896e1c7546f0c5044297f"
    Payjp::Charge.create(
      amount: purchase_customer_params[:item_id.price],
      card: purchase_customer_params[:token],
      currency: 'jpy'
    )
  end

end
