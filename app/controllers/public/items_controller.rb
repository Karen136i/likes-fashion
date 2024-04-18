class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.where(status:"on_sale").page(params[:page]).per(12)
    @categories = Category.all
    @total_items = @items.total_count
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
