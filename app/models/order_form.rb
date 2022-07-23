class OrderForm
  include ActiveModel::Model

  # 保存したいテーブルのカラム名
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :token

  # バリデーションの処理
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :block
    validates :phone_number, format: {with: /\A\d{10}\z|\A\d{11}\z/, message: 'is invalid' }
    validates :token
  end

  # データをテーブルに保存する処理
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(order_id: order.id, postcode: postcode, prefecture_id: prefecture_id, city: city, block: block,
                   building: building, phone_number: phone_number)
  end
end
