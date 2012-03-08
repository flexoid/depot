require "spec_helper"

describe ProductsController do
  describe "routing" do

    it "routes to #show" do
      get("/admin/products/1").should route_to("admin/products#show", :id => "1")
    end
  end
end
