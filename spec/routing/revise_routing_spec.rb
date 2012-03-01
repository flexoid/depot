require "spec_helper"

describe "Routing" do
  describe "of devise sessions controller" do

    it "routes to #new" do
      get("/users/sign_in").should route_to("devise/sessions#new")
    end

    it "routes to #create" do
      post("/users/sign_in").should route_to("devise/sessions#create")
    end

    it "routes to #destroy" do
      get("/users/sign_out").should route_to("devise/sessions#destroy") # Only for test environment
      #delete("/users/sign_out").should route_to("devise/sessions#destroy")
    end
  end

  describe "of devise passwords controller" do

    it "routes to #new" do
      get("/users/password/new").should route_to("devise/passwords#new")
    end

    it "routes to #edit" do
      get("/users/password/edit").should route_to("devise/passwords#edit")
    end

    it "routes to #create" do
      post("/users/password").should route_to("devise/passwords#create")
    end

    it "routes to #update" do
      put("/users/password").should route_to("devise/passwords#update")
    end
  end

  describe "of devise registrations controller" do

    it "routes to #new" do
      get("/users/sign_up").should route_to("devise/registrations#new")
    end

    it "routes to #edit" do
      get("/users/edit").should route_to("devise/registrations#edit")
    end

    it "routes to #cancel" do
      get("/users/cancel").should route_to("devise/registrations#cancel")
    end

    it "routes to #create" do
      post("/users").should route_to("devise/registrations#create")
    end

    it "routes to #update" do
      put("/users").should route_to("devise/registrations#update")
    end
  end
end
