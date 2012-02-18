require 'spec_helper'
include ActionView::Helpers::NumberHelper
include ActionView::Helpers::SanitizeHelper

describe StoreController do
  render_views

  describe "GET 'index'" do

    before(:each) do
      @products = []
      5.times do
        @products << Factory(:product)
      end
    end

    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have the right title" do
      get 'index'
      response.should have_selector("title", content: "Pragprog Books Online Store")
    end

    it "should have an entry for each product" do
      get 'index'
      response.should have_selector("div.entry", count: @products.count)
      @products.each do |product|
        response.should have_selector("div.entry") do |entry|
          entry.should have_selector("h3", content: product.title)
          entry.should contain(sanitize(product.description))
          entry.should have_selector("div.price_line>span.price", content: number_to_currency(product.price))
        end
      end
    end
  end

end
