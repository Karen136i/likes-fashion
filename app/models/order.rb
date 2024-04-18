class Order < ApplicationRecord
  belongs_to :customer
  has_many :cart_items
  has_many :order_details
  validates :name, presence: true
  validates :postal_code , presence: true
  validates :address, presence: true
  
  #  enum導入
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  enum status: { 入金待ち: 0, 入金確認: 1, 発送済み: 2 }
  enum shipping_status: { 着手不可: 0, 商品準備中: 1, 商品準備完了: 2 }

  after_update :update_shipping_status

  private

  def update_shipping_status
    case self.status
    when "入金待ち"
      self.shipping_status = :着手不可
    when "入金確認"
      self.shipping_status = :商品準備中
    when "発送済み"
      self.shipping_status = :発送済み
    end

    self.save if self.shipping_status_changed?
  end
  
end 
  
