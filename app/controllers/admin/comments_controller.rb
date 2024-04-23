class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @comment = Comment.new
    @review = Review.find(params[:review_id])
    @item = @review.item
  end
  
  def create
    @review = Review.find(params[:review_id])
    @item = @review.item  # レビューに関連付けられたアイテムをロード
    @comment = @review.comments.new(comment_params)
    @comment.admin_id = current_admin.id
  
    if @comment.save
      redirect_to admin_item_review_path(item_id: @review.item_id, id: @review.id), notice: 'お礼コメントが追加されました。'
    else
      flash.now[:alert] = "お礼コメントを追加できませんでした。"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:review_id])
    @comment = @review.comments.find(params[:id])
    @item = @review.item  # レビューに関連付けられた商品をロード
  end
  
  def update
    @review = Review.find(params[:review_id])
    @item = @review.item  # レビューに関連付けられたアイテムをロード
    @comment = @review.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to admin_review_path(@review), notice: 'コメントを更新しました。'
    else
      flash.now[:alert] = "お礼コメントを編集できませんでした。"
      render :edit
    end
  end
  
  def destroy
    @review = Review.find(params[:review_id])  # コメントが紐付いているレビューを正確に取得
    @comment = @review.comments.find(params[:id])  # 正しいコメントオブジェクトを取得
    @comment.destroy
    redirect_to admin_item_review_path(item_id: @review.item_id, id: @review.id), notice: 'コメントが削除されました。'  # 削除後はそのレビューの詳細ページへリダイレクト
  end
  
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
