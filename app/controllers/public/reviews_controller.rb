class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def new
    @review = Review.new
    @item = Item.find(params[:item_id])
  end
  
  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "Reviewを追加しました。"
      redirect_to public_review_path(@review.id)
    else
      flash.now[:alert] = "Reviewの追加に失敗しました。"
      render :new
    end
  end 

  def show
  end
  
  private
  
  def review_params
    params.require(:review).permit(:name, :introduction, :star)
  end 
end
