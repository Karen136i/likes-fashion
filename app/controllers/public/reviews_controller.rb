class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def new
  end

  def show
  end
end
