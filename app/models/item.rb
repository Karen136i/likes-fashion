class Item < ApplicationRecord
  enum status: { on_sale: 0, not_on_sale: 1, back_orderd: 2 }
  has_one_attached :image
  belongs_to :category, optional: true
  has_many :cart_items

  validates :category, presence: { message: "を選択してください" }
  validates :price, presence: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :image, presence: true
  validates :introduction, presence: true, length: { maximum: 70 }

  scope :search, ->(query) {
    where("name LIKE ?", "%#{query}%") if query.present?
  }
end
