class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def index
  end

  def show
  end
end
