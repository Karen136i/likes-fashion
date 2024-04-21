class Public::ReviewFavoritesController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  
  def create
    review = Review.find(params[:review_id])
    favorite = current_customer.review_favorites.new(review_id: @review.id)
    favorite.save
    redirect_to reviews_path # 適切なリダイレクト先に変更してください
  end

  def destroy
    review = Review.find(params[:review_id])
    favorite = current_customer.review_favorites.find_by(review_id: @review.id)
    favorite.destroy
    redirect_to reviews_path # 適切なリダイレクト先に変更してください
  end
  
  def self.favorited_by?(customer, review)
    exists?(customer_id: customer.id, review_id: review.id)
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end
end
