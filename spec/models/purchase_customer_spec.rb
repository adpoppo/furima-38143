require 'rails_helper'

RSpec.describe PurchaseCustomer, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_customer = FactoryBot.build(:purchase_customer, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '購入情報登録' do
    context '購入情報が登録できる場合' do
      it 'postal_code、prefecture_id、city、house_number、phone_numberが存在すれば登録できる' do
        expect(@purchase_customer).to be_valid
      end
      it 'building_nameが空でも登録できる' do
        @purchase_customer.building_name = ''
        expect(@purchase_customer).to be_valid
      end
    end

    context '購入情報が登録できない場合' do
      it 'postal_codeが空では登録できない' do
        @purchase_customer.postal_code = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角ハイフン含む正しい形式でなければ登録できない' do
        @purchase_customer.postal_code = '1234567'
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Postal code is invalid.Enter it as follows (e.g. 123-4567)")
      end
      it 'prefecture_idが0では登録出来ない' do
        @purchase_customer.prefecture_id = 0
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では登録できない' do
        @purchase_customer.city = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空では登録できない' do
        @purchase_customer.house_number = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @purchase_customer.phone_number = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10桁以上11桁でなければ登録できない' do
        @purchase_customer.phone_number = '123456789'
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include('Phone number is too short.')
      end
      it 'phone_numberが半角数値でなければ登録できない' do
        @purchase_customer.phone_number = '００００００００００'
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Phone number is invalid. Input only number.")
      end
      it 'userが紐づいていないと登録できない' do
        @purchase_customer.user_id = nil
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていないと登録できない' do
        @purchase_customer.item_id = nil
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
