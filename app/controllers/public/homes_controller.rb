class Public::HomesController < ApplicationController

  def top
    @random_items = Item.order("RANDOM()").limit(4)  # ランダムに4つのアイテムを選択
  end

  def about
  end
end
