class Public::ReviewFavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @review = Review.find(params[:review_id])
    @favorite = current_customer.review_favorites.new(review_id: @review.id)
    @favorite.save
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js   # create.js.erb を呼び出す
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @favorite = current_customer.review_favorites.find_by(review_id: @review.id)
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js   # destroy.js.erb を呼び出す
    end
  end
end
