class Public::CategoriesController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def show
  end
end
