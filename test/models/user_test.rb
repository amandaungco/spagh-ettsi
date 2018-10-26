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

  describe 'becoming a seller' do
    let(:guest) {users(:guest)}
    let(:buyer) {users(:buyer)}

    it 'allows a user with an account to become a seller' do
      expect(buyer.is_a_seller).must_equal false

      buyer.is_a_seller = true
      buyer.save
      expect(buyer.is_a_seller).must_equal true
    end

    it 'does not allow a guest user to become a seller' do
      expect(guest.is_a_seller).must_equal false
      guest.is_a_seller = true
      guest.save

      valid = guest.valid?

      expect(valid).must_equal false
      expect(guest.errors.messages).must_include :is_a_seller
      expect(guest.errors.messages[:is_a_seller]).must_equal ["Must be a registered user to become a seller"]
    end

  end

  describe "custom methods" do
    let(:seller) {users(:seller)}
    describe ' total_revenue' do
      it 'should return the total revenue for all products sold by a given merchant' do
        expect(seller.total_revenue).must_equal 699
      end

      it 'should return the total revenue by order status for all products sold by a given merchant' do
        expect(seller.total_revenue_by_status('paid')).must_equal 299

        expect(seller.total_revenue_by_status('complete')).must_equal 400
      end
    end

    describe 'product status' do
      it 'sorts a merchants prodcuts by their status'do

        expect(seller.product_status(true)[0]).must_be_instance_of Product
        expect(seller.product_status(true)[0].name).must_equal 'spaghetti'

      end
    end

    describe "Create user using oauth" do
      it 'creates an instance of a user using github auth_hash' do
        mock_hash = {
          provider: 'github',
          uid: 12345,
          info: {
            email: 'test@test.com',
            name: 'Please pass this test'
          }
        }

        expect(User.build_from_github(mock_hash)).must_be_instance_of User

      end

    end

  end

end
