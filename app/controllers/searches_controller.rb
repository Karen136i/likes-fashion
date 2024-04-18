class SearchesController < ApplicationController

 def search
    @content = params[:content]
    @method = params[:method]

    # 顧客も管理者もログインしていない場合は、商品のみを検索
    @records = Item.search_for(@content, @method)
 end

end
