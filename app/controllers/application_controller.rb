class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_cart
  check_authorization :unless => :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, CanCan::AccessDenied do |exception|
    redirect_to store_url, alert: exception.message.capitalize
  end

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
