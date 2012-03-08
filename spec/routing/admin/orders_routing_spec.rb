require "spec_helper"

describe Admin::OrdersController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/orders").should route_to("admin/orders#index")
    end

    it "routes to #show" do
      get("/admin/orders/1").should route_to("admin/orders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/orders/1/edit").should route_to("admin/orders#edit", :id => "1")
    end

    it "routes to #update" do
      put("/admin/orders/1").should route_to("admin/orders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/orders/1").should route_to("admin/orders#destroy", :id => "1")
    end

  end
end
