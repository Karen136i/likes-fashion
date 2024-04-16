class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def new
    @item = Item.find(params[:item_id])
  end

  def show
  end
end
