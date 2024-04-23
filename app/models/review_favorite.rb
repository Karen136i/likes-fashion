class ReviewFavorite < ApplicationRecord
  # レビューに対するいいね機能
  belongs_to :customer
  belongs_to :review

  # このメソッドで、特定のユーザーが特定のレビューにいいねをしているかを確認
  def self.favorited_by?(customer, review)
    exists?(customer_id: customer.id, review_id: review.id)
  end

end
