require 'rails_helper'
require 'pp'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can navigate to product details page by clicking on the details button" do
    visit root_path

    # commented out b/c it's for debugging only
    # save_and_open_screenshot 'home_page_for_product_details.png'

    page.first('article.product').find_link('Details »').click

    sleep(5)

    # save_and_open_screenshot 'product_page.png'

    expect(page).to have_css 'article.product-detail'
  end
end
