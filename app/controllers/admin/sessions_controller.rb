class Admin::SessionsController < Devise::SessionsController

  # def create
  #   super do |resource|
  #     respond_with resource, location: after_sign_in_path_for(resource) and return
  #   end
  # end

  def after_sign_in_path_for(resource)
    admin_items_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
end
  