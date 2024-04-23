class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order_detail, only: [:update]

  def update
    if @order_detail.update(order_detail_params)
      update_order_status
      redirect_to admin_order_path(@order_detail.order)
    else
      render 'admin/orders/show'
    end
  end

  private

  def set_order_detail
    @order_detail = OrderDetail.find(params[:id])
  end

  def order_detail_params
    params.require(:order_detail).permit(:shipping_status)
  end

  def update_order_status
    @order = @order_detail.order
    if @order.order_details.all? { |detail| detail.shipping_status == "商品準備完了" }
      @order.update(status: "発送済み")
    end
  end
  
end
