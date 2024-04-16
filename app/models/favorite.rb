class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  belongs_to :review
  
  def self.favorited_by?(customer, item)
    exists?(customer: customer, item: item)
  end
end
