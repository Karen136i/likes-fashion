class Public::ReviewFavoritesController < ApplicationController
  before_action :authenticate_customer! # アクセス制限

  def create
    review = Review.find(params[:review_id])
    favorite = current_customer.review_favorites.new(review_id: review.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    review = Review.find(params[:review_id])
    favorite = current_customer.review_favorites.find_by(review_id: review.id)
    favorite.destroy
    redirect_to request.referer
  end

end
