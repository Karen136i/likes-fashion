class SearchesController < ApplicationController
  def search
    @content = params[:content]

    # デバッグ出力
    Rails.logger.info "Search content: #{@content}"

    # 検索内容が空白の場合の処理
    if @content.blank?
      flash[:alert] = "検索キーワードを入力してください。"
      redirect_back(fallback_location: root_path) and return
    end

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
