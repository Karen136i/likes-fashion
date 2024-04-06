class Public::AddressesController < ApplicationController
  before_action :authenticate_customer! #アクセス制限
  def index
  end

  def edit
  end
end
