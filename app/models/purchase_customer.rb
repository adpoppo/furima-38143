class PurchaseCustomer
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number,
                :purchase_id

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid.Enter it as follows (e.g. 123-4567)' }
    validates :city
    validates :house_number
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :phone_number, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is too short.' }
  validates :phone_number, numericality: { only_integer: true, message: 'is invalid. Input only number.' }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Customer.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number,
                    building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
