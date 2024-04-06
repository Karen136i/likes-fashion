class Public::CustomersController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def show
  end

  def edit
  end

  def unsubscribe
  end
end
