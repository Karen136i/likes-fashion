class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer! #アクセス制限

  def show
    @favorites = current_customer.favorites.includes(:item)
  end

  def create
    item = Item.find(params[:item_id])
    favorite = current_customer.favorites.new(item_id: item.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    item = Item.find(params[:item_id])
    favorite = current_customer.favorites.find_by(item_id: item.id)
    favorite.destroy
    redirect_to request.referer
  end

end