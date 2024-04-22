class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.includes(:customer, :item).page(params[:page]).per(5)
  end

  def show
    @item = Item.find(params[:item_id])  # item_id パラメータを使って Item をロード
    @review = @item.reviews.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_reviews_path, notice: '更新されました'
  end


  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to admin_reviews_path
  end

end
