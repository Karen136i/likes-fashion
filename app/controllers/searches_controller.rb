class SearchesController < ApplicationController

# def search
#     @content = params[:content]
#     @model = params[:model]
#     @method = params[:method]
#     @categories = Category.all
    
#     # 管理者側の検索結果の記述
#     if @model == "customer"
#       @records = Customer.search_for(@content, @method).page(params[:page]).per(12)
#     else
#       @records_item = Item.search_for(@content, @method).page(params[:page]).per(12)
#     end
    
#     @total_items = @records.count
# end

def search
    @content = params[:content]
    @method = params[:method]
    @categories = Category.all
    
    if params[:model] == "customer"
      @records = Customer.search_for(@content, @method).page(params[:page]).per(12)
    else
      @records = Item.search_for(@content, @method).page(params[:page]).per(12)
    end
    
    @total_items = @records.count
end

end
