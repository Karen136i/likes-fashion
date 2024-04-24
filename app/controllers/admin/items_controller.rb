class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @item = Item.new
    @categories = Category.all
  end

  def index
    @items = Item.page(params[:page])
  end

  def create
    @item = Item.new(item_params)
    @categories = Category.all
    if @item.save
      flash[:notice] = "Itemを追加しました。"
      redirect_to admin_item_path(@item.id)
    else
      flash.now[:alert] = "Itemの追加に失敗しました。"
      render :new  # エラーがある場合はnewアクションを再度表示
    end
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def reviews
    @item = Item.find(params[:id])
    @reviews = @item.reviews.includes(:customer).order(created_at: :desc)
    # アイテムに紐づくレビューを表示するためのデータを取得
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
    item = Item.find(params[:id])
    item.destroy
    redirect_to admin_items_path
  end
  
  def reviews
    @item = Item.find(params[:id])
    @reviews = @item.reviews.includes(:customer).page(params[:page]).per(10)
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :name, :introduction, :price, :status, :image)
  end
end
