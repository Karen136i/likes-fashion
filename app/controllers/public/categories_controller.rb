class Public::CategoriesController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  
  def show
    @category = Category.find(params[:id])
    @items = @category.items # カテゴリーに関連するアイテムを取得するためのコード。必要に応じて調整してください。
    @categories = Category.all # すべてのカテゴリーを取得
    @total_items = @category.items.count
  end
end
