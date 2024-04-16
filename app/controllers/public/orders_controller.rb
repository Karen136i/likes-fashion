class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders.page(params[:page])
  end

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    set_order_address(@order)
    @cart_items = current_customer.cart_items
    @sum = calculate_order_total(@cart_items)
    render :confirm
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.total_payment = calculate_order_total(current_customer.cart_items) + @order.shipping_cost

    if @order.save
      create_order_details(@order)
      current_customer.cart_items.destroy_all
      redirect_to thanks_public_orders_path
    else
      @addresses = current_customer.addresses
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :status, :shipping_cost, :total_payment)
  end

  # 注文合計金額の計算
  def calculate_order_total(cart_items)
    cart_items.inject(0) { |sum, cart_item| sum + (cart_item.amount * cart_item.item.price) }
  end

  # 注文詳細の作成
  def create_order_details(order)
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_details = OrderDetail.new(
        order_id: order.id,
        item_id: cart_item.item.id,
        price: cart_item.item.price,
        amount: cart_item.amount
      )
      order_details.save!
    end
  end

  # 注文の配送先を設定
  def set_order_address(order)
    if params[:order][:select_address] == "0"
      order.postal_code = current_customer.postal_code
      order.address = current_customer.address
      order.name = current_customer.full_name
    elsif params[:order][:select_address] == "1"
      address = Address.find(params[:order][:address_id])
      order.postal_code = address.postal_code
      order.address = address.address
      order.name = address.name
    elsif params[:order][:select_address] == "2"
      order.customer_id = current_customer.id
    end
  end
end
