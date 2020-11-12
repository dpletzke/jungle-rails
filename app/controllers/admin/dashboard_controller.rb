class Admin::DashboardController < ApplicationController
  before_filter :authenticate

  def show
    @count_products = Product.count
    @count_categories = Category.count
  end


end
