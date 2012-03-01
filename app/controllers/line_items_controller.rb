class LineItemsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :create
  skip_authorize_resource only: [:create, :destroy]
  skip_authorization_check only: [:create, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    if product = Product.find_by_id(params[:product_id])
      @line_item = @cart.add_product(product)
    else
      @line_item = LineItem.new
    end

    respond_to do |format|
      if @line_item.save
        session[:counter] = 0
        format.html { redirect_to store_url }
        format.js { @current_item = @line_item }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    if @line_item.quantity > 1
      @line_item.quantity -= 1
      @line_item.save
    else
      @line_item.destroy
    end

    respond_to do |format|
      format.html { redirect_to store_url }
      format.js
      format.json { head :no_content }
    end
  end
end
