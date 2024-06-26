class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [:show, :update]

  def index
    if params[:customer_id].present?
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders .page(params[:page]).per(10).order(created_at: :desc)
    else
      @orders = Order.all.page(params[:page]).per(10).order(created_at: :desc)
    end 
  end

  def show
    @order_details = @order.order_details
  end

  def update
    if @order.update(order_params)
      update_order_details_shipping_status if @order.status == "入金確認"
      redirect_to admin_order_path(@order), notice: '注文ステータスが正常に更新されました。'
    else
      flash[:error] = '注文ステータスの更新に失敗しました。'
      render :show
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end

  def update_order_details_shipping_status
    @order.order_details.update_all(shipping_status: '商品準備中')
  end

end
