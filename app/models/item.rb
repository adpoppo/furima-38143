class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :freight
  belongs_to :prefecture
  belongs_to :ship_day
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :item_name, length: { maximum: 40 }
    validates :item_description, length: {maximum: 1000}
  end

    validates :price, presence: true
    validates :price, numericality: { only_integer: true, message: "is invalid. Input half-width characters." }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range." }

  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :freight_id
    validates :prefecture_id
    validates :ship_day_id
  end

end
