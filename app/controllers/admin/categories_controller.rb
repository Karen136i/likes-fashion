class Admin::CategoriesController < ApplicationController
  
  def index
    @categories = Category.page(params[:page])
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    @categories = Category.all
    if @category.save
      flash[notice] = "カテゴリーを追加しました。"
      redirect_to admin_categories_path
    else 
      flash.now[:alert] = "カテゴリーの追加に失敗しました。"
      render :index
    end 
  end  

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリーを変更しました。"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "カテゴリーの変更に失敗しました。"
      render :edit
    end
  end 
  
  private

  def category_params
    params.require(:category).permit(:name)
  end
    
end
