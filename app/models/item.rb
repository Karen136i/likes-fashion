class Item < ApplicationRecord
  enum status: { on_sale: 0, not_on_sale: 1, back_ordered: 2 }
  has_one_attached :image
  belongs_to :category
  has_many :cart_items
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :category, presence: { message: "を選択してください" }
  validates :price, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :image, presence: true
  validates :introduction, presence: true, length: { maximum: 70 }

  def price_without_tax
    tax_rate = 0.1 # 仮の税率（10%）
    (price * (1 - tax_rate)).round
  end

  # 商品の検索を行うメソッド
  def self.search_for(content, method)
    case method
    when "perfect"
      Item.where(name: content)
    when "forward"
      Item.where("name LIKE ?", "#{content}%")
    when "backward"
      Item.where("name LIKE ?", "%#{content}")
    when "partial"
      Item.where("name LIKE ?", "%#{content}%")
    else
      Item.none
    end
  end
  # ここまで

  # ソート機能実装
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  # ここまで

end