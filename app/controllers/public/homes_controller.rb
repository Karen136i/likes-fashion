class Public::HomesController < ApplicationController

  def top
    @items = Item.on_sale
    @random_items = if Rails.env == "development"
                       Item.on_sale.order("RANDOM()").limit(4)  # ランダムに4つのアイテムを選択
                    elsif Rails.env == "production"
                       Item.on_sale.order("RAND()").limit(4)
                    end
  end
  
end
