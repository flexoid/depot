require 'spec_helper'

describe "Products" do

  describe "creation" do

    describe "failure" do

      it "should not make a new product with empty parameters" do
        lambda do
          visit new_product_path
          fill_in "Title",        :with => ""
          fill_in "Description",  :with => ""
          attach_file "product_image", File.join(Rails.root, "app/assets/images/ruby.jpg")
          fill_in "Price",        :with => ""
          click_button "Create Product"
          response.should render_template('products/new')
          # response.should have_selector("div#error_explanation")
        end.should_not change(Product, :count)
      end
    end

    describe "success" do

      it "should make a new product" do
        @product = Factory.attributes_for(:product)
        lambda do
          visit new_product_path
          fill_in "Title",        :with => @product[:title]
          fill_in "Description",  :with => @product[:description]
          attach_file "product_image", File.join(Rails.root, "app/assets/images/ruby.jpg")
          fill_in "Price",        :with => @product[:price]
          click_button "Create Product"
          response.should have_selector("p#notice", :content => "Product was successfully created.")
          response.should render_template('products/show')
        end.should change(Product, :count).by(1)
      end
    end
  end

  describe "updating" do

    before(:each) do
      @product = Factory(:product)
    end

    describe "failure" do

      it "shouldn't update porduct with invalid parameters" do
        lambda do
          visit edit_product_path(@product)
          fill_in "Title",        :with => ""
          fill_in "Description",  :with => ""
          attach_file "product_image", File.join(Rails.root, "app/assets/images/ruby.jpg")
          fill_in "Price",        :with => ""
          click_button "Update Product"
          response.should render_template('products/edit')
          # response.should have_selector("div#error_explanation")
          @product.reload
        end.should_not change(@product, :title)
      end
    end

    describe "success" do

      it "should update product" do
        lambda do
          visit edit_product_path(@product)
          fill_in "Title",        :with => @product[:title] + " New Release"
          fill_in "Description",  :with => @product[:description]
          attach_file "product_image", File.join(Rails.root, "app/assets/images/ruby.jpg")
          fill_in "Price",        :with => @product[:price]
          click_button "Update Product"
          response.should have_selector("p#notice", :content => "Product was successfully updated.")
          response.should render_template('products/show')
          @product.reload
        end.should change(@product, :title).from(@product[:title]).to(@product[:title] + " New Release")
      end
    end
  end
end
