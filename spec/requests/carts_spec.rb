require 'spec_helper'

describe "Carts" do
  describe "GET /carts" do
    it "works! (now write some real specs)" do
      visit carts_path
      response.status.should be(200)
    end
  end
end
