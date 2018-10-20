require "test_helper"

class UserTest < ActiveSupport::TestCase
  describe User do
    let(:user) { User.new(full_name: 'Chris McNally', email: 'chris@ada.com', uid:'12345', provider: 'github') }

    it "must be valid" do
      value(user).must_be :valid?
    end

    it 'has required fields' do
      fields = [:full_name, :email, :uid, :provider]

      fields.each do |field|
        expect(user).must_respond_to field
      end
    end
  end

  describe 'Relationships' do
    let(:user) { users(:buyer)}

    it 'can have many products' do

      user.products << Product.first
      products = user.products

      expect(products.length).must_be :>=, 1
      products.each do |product|
        expect(product).must_be_instance_of Product
      end
    end

    it 'can have many orders' do

      user.orders << Order.first
      orders = user.orders

      expect(orders.length).must_be :>=, 1
      orders.each do |order|
        expect(order).must_be_instance_of Order
      end
    end

    it 'can have many addresses' do

      user.addresses << Address.first
      addresses = user.addresses

      expect(addresses.length).must_be :>=, 1
      addresses.each do |address|
        expect(address).must_be_instance_of Address
      end
    end

    it 'can have many payments' do

      user.payments << Payment.first
      payments = user.payments

      expect(payments.length).must_be :>=, 1
      payments.each do |payment|
        expect(payment).must_be_instance_of Payment
      end
    end

    it 'can have many reviews' do

      user.reviews << Review.first
      reviews = user.reviews

      expect(reviews.length).must_be :>=, 1
      reviews.each do |review|
        expect(review).must_be_instance_of Review
      end
    end
  end

  describe 'validations' do
    it 'must have a full_name' do
      user = users(:seller)
      user.full_name = nil
      user.save

      valid = user.valid?

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :full_name
    end

    it 'must have an email' do
      user = users(:seller)
      user.email = nil
      user.save

      valid = user.valid?

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :email
    end

    it 'must have a uid' do
      user = users(:seller)
      user.uid = nil
      user.save

      valid = user.valid?

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :uid
    end

    it 'must have a provider' do
      user = users(:seller)
      user.provider = nil
      user.save

      valid = user.valid?

      expect(valid).must_equal false
      expect(user.errors.messages).must_include :provider
    end
  end
end
