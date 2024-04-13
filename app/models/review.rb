class Review < ApplicationRecord
  has_many :favorites, dependent: :destroy
end
