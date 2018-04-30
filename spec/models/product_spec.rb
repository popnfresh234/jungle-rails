require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    # it { should validate_presence_of(:name) }
    # it { should validate_presence_of(:price)}
    # it { should validate_presence_of(:quantity)}
    # it { should validate_presence_of(:category)}


    it 'is valid if all fields present' do
      category = Category.new({name: 'Test Category'})
      product = Product.new({ name: 'Test', price: 1, quantity: 1, category: category})
      
      expect(product.valid?).to be true
    end

    it 'requires a name to be present' do
      category = Category.new({name: 'Test Category'})
      product = Product.new({ name: nil, price: 1, quantity: 1, category: category})
      product.valid?
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'requires a price to be present' do
      category = Category.new({name: 'Test Category'})
      product = Product.new({name: 'Test product', price: nil, quantity: 1, category: category})
      product.valid?
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'requires a quantity to be present' do
      category = Category.new({name: 'Test Category'})
      product = Product.new({name: 'Test product', price: 1, quantity: nil, category: category})
      product.valid?
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'requires a category to be present' do
      category = Category.new({name: 'Test Category'})
      product = Product.new({name: 'Test prdouct', price: 1, quantity: 1, category: nil})
      product.valid?
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
