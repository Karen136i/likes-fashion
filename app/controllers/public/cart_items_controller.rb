class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer! #アクセス制限

  def index
    @cart_items = current_customer.cart_items
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def create
    existing_cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])

    if existing_cart_item
      existing_cart_item.amount += cart_item_params[:amount].to_i
      if existing_cart_item.save
        redirect_to public_cart_items_path, notice: 'カート内の商品数量を更新しました。'
      else
        logger.error existing_cart_item.errors.full_messages.join(', ')
        redirect_to root_path, alert: 'カートの商品数量を更新できませんでした。'
      end
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        redirect_to public_cart_items_path, notice: '商品をカートに追加しました。'
      else
        logger.error @cart_item.errors.full_messages.join(', ')
        redirect_to root_path, alert: '商品をカートに追加できませんでした。'
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path, notice: 'カートの商品数量を更新しました。'
    else
      logger.error @cart_item.errors.full_messages.join(', ')
      redirect_to public_cart_items_path, alert: 'カートの商品数量を更新できませんでした。'
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_all_destroy_path, notice: 'カート内のすべての商品が削除されました'
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end