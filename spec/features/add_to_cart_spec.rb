require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

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

  scenario "They can click on the add-to-cart button so their cart increases by one" do
    visit root_path

    # save_and_open_screenshot 'cart_before_add.png'

    page.first('article.product').click_button 'Add'

    sleep(1)

    # save_and_open_screenshot 'cart_after_add.png'

    expect(page.find('a', text: "(1)")).to be_truthy
  end

end
