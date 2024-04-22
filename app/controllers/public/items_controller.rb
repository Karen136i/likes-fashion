class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.where(status:"on_sale").page(params[:page]).per(12)
    @categories = Category.all
    @total_items = @items.total_count
    # ソート機能の実装
    case params[:sort]
    when "latest"
      @items = @items.order(created_at: :desc)
    when "oldest"
      @items = @items.order(created_at: :asc)
    when "highest_rated"
      @items = @items.left_joins(:reviews).group(:id).order('AVG(reviews.star) DESC')
    else
      @items = @items.order(created_at: :desc)
    end
    # ここまで
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  private
  
  def item_params
    params.require(:item).permit(:category_id, :introduction, :image, :price, :status)
  end 
  
end
