class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  before_action :check_purchase, only: [:new, :create]
  before_action :check_review_capacity, only: [:new, :create] 

  def new
    @review = Review.new
    @reviews = Review.includes(:comment).all
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
    if params[:item_id].present?
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
    else
      redirect_to root_path, alert: "アイテムが指定されていません。"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    item_id = @review.item_id  # 削除するレビューに関連するアイテムのIDを保存
    if @review.customer_id == current_customer.id
      @review.destroy
      redirect_to public_reviews_path(item_id: item_id), notice: "レビューを削除しました。"
    else
      redirect_to public_reviews_path(item_id: item_id), alert: "この操作は許可されていません。"
    end
  end

  private

  def review_params
    params.require(:review).permit(:nickname, :review_content, :star, images: [])
  end

  def check_purchase
    @item = Item.find(params[:item_id])
    unless current_customer.orders.joins(:order_details).where(order_details: { item_id: @item.id }).exists?
      redirect_to public_items_path, alert: "この商品のレビューを書くためには購入が必要です。"
    end
  end

  def check_review_capacity
    @item = Item.find(params[:item_id])
    purchased_quantity = total_purchased_quantity(@item.id)
    written_reviews = total_reviews_written(@item.id)

    if written_reviews >= purchased_quantity
      redirect_to public_item_path(@item), alert: "この商品のレビュー可能数を超えています。"
    end
  end

  def total_purchased_quantity(item_id)
    current_customer.orders.joins(:order_details)
                    .where(order_details: { item_id: item_id })
                    .sum("order_details.amount")
  end

  def total_reviews_written(item_id)
    Review.where(customer_id: current_customer.id, item_id: item_id).count
  end

end