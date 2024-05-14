class SearchesController < ApplicationController
  def search
    @content = params[:content]

    # デバッグ出力
    Rails.logger.info "Search content: #{@content}"

    if admin_signed_in?
      case params[:model]
      when "customer"
        @customers = Customer.search_for(@content)
      when "item"
        @items = Item.search_for(@content)
      end
    else
      @items = Item.search_for(@content)
      @total_items = @items.count
    end
  end
end
