require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品の出品登録' do
    before do
      @item = FactoryBot.create(:item)
    end

    context '商品の出品登録ができる時' do
      it 'すべての項目が問題なく入力されていると登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品の出品登録ができないとき' do

      it 'ユーザーではないときは登録できない' do
        @item.user_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end

      it '商品画像がないと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空だと登録できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が空だと登録できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが空だと登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'カテゴリーの情報が「---」だと登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it '商品状態が空だと登録できない' do
        @item.item_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end

      it '商品状態が「---」だと登録できない' do
        @item.item_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Item status must be other than 0')
      end

      it '配送料について空だと登録できない' do
        @item.transport_cost_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Transport cost can't be blank")
      end

      it '配送料について「---」だと登録できない' do
        @item.transport_cost_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Transport cost must be other than 0')
      end

      it '発送元が空だと登録できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送元が「---」だと登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it '発送日数が空だと登録できない' do
        @item.transport_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Transport day can't be blank")
      end

      it '発送日数が「---」だと登録できない' do
        @item.transport_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Transport day must be other than 0')
      end

      it '価格が空だと登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is not a number')
      end

      it '価格が300円未満だと登録できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が9,999,999円を超えると登録できない' do
        @item.price = 100000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '価格が半角数字以外では登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

    end
  end
end
