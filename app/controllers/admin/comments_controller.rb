class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @comment = Comment.new
    @review = Review.find(params[:review_id])
    @item = @review.item
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.review_id = params[:review_id]
    @comment.admin_id = current_admin
    if @comment.save
      redirect_to admin_reviews_path, notice: 'コメントが追加されました。'
    else
      render :new
    end
  end

  def edit
  end
  
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
