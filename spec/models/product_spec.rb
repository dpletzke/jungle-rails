require 'rails_helper'
require 'pp'

describe Product, type: :model do
  describe 'Validations' do
    before(:each) do

      fields = {
        name: 'Bucket',
        description: "Long description",
        image: 'http://www.fillmurray.com/250/250',
        price_cents: 1200,
        quantity: 2,
        category: Category.new({name: 'Homemade'})
      } 
      @product = Product.new(fields)

    end

    it "throws no errors when all fields are given" do
      @product.save()
      expect(@product.errors.full_messages).to be_empty
    end

    context 'throws an error when missing' do

      it "name" do
        @product[:name] = nil
        @product.save()

        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it "price_cents" do
        @product[:price_cents] = nil
        @product.save()
    
        expect(@product.errors.full_messages).to include(
          "Price can't be blank",
          "Price is not a number",
          "Price cents is not a number",
        )
      end

      it "quantity" do
        @product[:quantity] = nil
        @product.save()
    
        expect(@product.errors.full_messages).to include(
          "Quantity can't be blank",
        )
      end

      it "category" do
        expect { @product[:category] = nil }.to raise_error(ActiveModel::MissingAttributeError)
      end

    end  

  end
end

