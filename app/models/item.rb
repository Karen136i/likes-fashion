class Item < ApplicationRecord
  enum status: { on_sale: 0, not_on_sale: 1, back_ordered: 2 }
  has_one_attached :image
  belongs_to :category
  has_many :cart_items
  has_many :favorites, dependent: :destroy

  validates :category, presence: { message: "を選択してください" }
  validates :price, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :image, presence: true
  validates :introduction, presence: true, length: { maximum: 70 }

  def price_without_tax
    tax_rate = 0.1 # 仮の税率（10%）
    (price * (1 - tax_rate)).round
  end

  scope :search, ->(query) {
    where("name LIKE ?", "%#{query}%") if query.present?
  }
end