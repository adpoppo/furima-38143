class ItemsController < ApplicationController
  def index
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_description, :category_id, :condition_id, :freight_id, :prefecture_id, :ship_day_id, :price).merge(user_id: current_user.id)
  end

end
