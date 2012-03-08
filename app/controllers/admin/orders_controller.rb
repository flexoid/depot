class Admin::OrdersController < Admin::BaseController
  load_and_authorize_resource

  # GET /admin/orders
  # GET /admin/orders.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /admin/orders/1
  # GET /admin/orders/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /admin/orders/1/edit
  def edit
  end

  # PUT /admin/orders/1
  # PUT /admin/orders/1.json
  def update
    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to [:admin, @order], notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/orders/1
  # DELETE /admin/orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to admin_orders_url }
      format.json { head :no_content }
    end
  end
end
