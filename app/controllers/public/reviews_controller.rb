class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer! #アクセス制限

  def new
    @review = Review.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    @review.item_id = params[:item_id]
    if @review.save
      flash[:notice] = "Reviewを追加しました。"
      redirect_to public_reviews_path(item_id: @review.item_id)  # 修正
    else
      flash.now[:alert] = "Reviewの追加に失敗しました。"
      render :new
    end
  end

  def index
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews.page(params[:page]).per(10)
  
    case params[:sort]
    when "latest"
      @reviews = @reviews.reorder(created_at: :desc)
    when "oldest"
      @reviews = @reviews.reorder(created_at: :asc)
    when "highest_rated"
      @reviews = @reviews.left_joins(:review_favorites).group('reviews.id').reorder('AVG(reviews.star) DESC')
    else
      @reviews = @reviews.reorder(created_at: :desc)
    end
  end



  private

  def review_params
    params.require(:review).permit(:nickname, :review_content, :star)
  end

end
