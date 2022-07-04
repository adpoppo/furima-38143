class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: :index

  def index
    @purchase_customer = PurchaseCustomer.new
  end

  def create
    @purchase_customer = PurchaseCustomer.new(purchase_customer_params)
    if @purchase_customer.valid?
      pay_item
      @purchase_customer.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_customer_params
    params.require(:purchase_customer).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id].to_i)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_customer_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? && current_user.id != @item.user_id && @item.purchase == nil
  end

end
