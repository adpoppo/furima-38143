class PurchaseCustomer
  include Activemodel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :purchase_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid.Enter it as follows (e.g. 123-4567)" }
    validates :prefecture_id, numericality:{ other_than: 0, message: "can't be blank" }
    validates :city
    validates :house_number
    validates :purchase_id
  end
  validates :phone_number presence: true
  validates :phone_number format: { with: /\A\d{10,11}\z/, message: 'is too short.' }
  validates :phone_number numericality: { only_integer: true, message: 'is invalid. Input only number.' }
  
  def save
    purchase = Purchase.create(user_id: current_user.id, item_id: params[:item.id])
    Customer.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase_id)
  end
end