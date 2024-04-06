class Public::OrdersController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def new
  end

  def index
  end

  def show
  end

  def thanks
  end
end
