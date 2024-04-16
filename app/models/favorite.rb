class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def self.favorited_by?(customer, item)
    exists?(customer: customer, item: item)
  end
end
