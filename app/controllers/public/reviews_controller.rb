class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def new
    @review = Review.new
    @item = Item.find(params[:item_id])
  end

  def index
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews.page(params[:page]).per(10)
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    @review.item_id = params[:item_id]
    if @review.save
      flash[:notice] = "Reviewを追加しました。"
      redirect_to public_reviews_path
    else
      flash.now[:alert] = "Reviewの追加に失敗しました。"
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:nickname, :review_content, :star)
  end

end
