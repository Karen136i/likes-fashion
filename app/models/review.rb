class Review < ApplicationRecord
  
  belongs_to :item
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :review_favorites, dependent: :destroy #レビューに対するいいね機能
  
  validates :nickname, presence: true
  validates :review_content, presence: true
  validates :star, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  # ソート機能実装
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  # ここまで

end
