class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @item = Item.new
    @categories = Category.all
  end

  def index
    @items = Item.search(params[:id]).page(params[:page])
  end

  def create
    @item = Item.new(item_params)
    @categories = Category.all
    if @item.save
      flash[:natice] = "Itemを追加しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "Itemの追加に失敗しました。"
      render new_admin_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
  end

  def update
    @item = Item.find(params[:id])
    @categories = Category.all
    if @item.update(item_params)
      flash[:notice] = "情報を変更しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "情報の変更に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    
  end 

  private
  def item_params
    params.require(:item).permit(:category_id, :name, :introduction, :price, :is_active, :image)
  end

end
