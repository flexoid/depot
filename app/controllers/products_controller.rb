class ProductsController < ApplicationController
  load_and_authorize_resource

  def show
    @cart = current_cart
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end
end
