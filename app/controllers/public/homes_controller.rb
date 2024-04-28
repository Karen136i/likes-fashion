class Public::HomesController < ApplicationController

  def top
    @items = Item.where(status:"on_sale")
    @random_items = if Rails.env == "development"
                       Item.order("RANDOM()").limit(4)  # ランダムに4つのアイテムを選択
                    elsif Rails.env == "production"
                       Item.order("RAND()").limit(4)
                    end
  end

  def about
  end
end
