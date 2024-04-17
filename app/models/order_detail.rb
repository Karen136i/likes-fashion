class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  # 商品の小計を計算するメソッド
  def subtotal
    self.amount * self.price
  end
end