class Review < ApplicationRecord
  
  belongs_to :item
  belongs_to :customer
  has_many :comments, dependent: :destroy
  has_many :review_favorites, dependent: :destroy
  
  validates :review_content, presence: true
  validates :star, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
