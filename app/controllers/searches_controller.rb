class SearchesController < ApplicationController

def search
  @content = params[:content]
  # 管理者がログインしている場合のサーチボックス
  if admin_signed_in?
    case params[:model]
    when "customer"
      @customers = Customer.where('last_name LIKE :query OR first_name LIKE :query OR email LIKE :query', query: "%#{@content}%")
    when "item"
      @items = Item.where('name LIKE ?', "%#{@content}%")
    end
  # ここまで
  else
    # ユーザー側の商品検索（管理者や顧客がログインしていない場合も含む）
    @items = Item.where('name LIKE ?', "%#{@content}%")
    @total_items = @items.count # 検索結果の件数を数えて @total_items に代入
  end
end


end

