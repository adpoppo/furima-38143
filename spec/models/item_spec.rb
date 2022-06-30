require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    context '出品登録できる場合' do
      it 'image、item_name、item_description、category、condition、freight、prefecture、ship_day、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品登録できない場合' do
      it 'imageが空では登録出来ない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空では登録出来ない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'item_descriptionが空では登録出来ない' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end
      it 'category_idが0では登録出来ない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'condition_idが0では登録出来ない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'freight_idが0では登録出来ない' do
        @item.freight_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Freight can't be blank")
      end
      it 'prefecture_idが0では登録出来ない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'ship_day_idが0では登録出来ない' do
        @item.ship_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship day can't be blank")
      end
      it 'priceが空では登録出来ない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが全角では登録出来ない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters.',
                                                      'Price is out of setting range.')
      end
      it 'priceが300未満では登録出来ない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range.')
      end
      it 'priceが9999999より多いと登録出来ない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range.')
      end
    end
  end
end
