class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def index
  end
end
