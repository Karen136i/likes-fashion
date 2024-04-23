class Comment < ApplicationRecord
  
  belongs_to :review
  belongs_to :admin
  validates :content, presence: true
end