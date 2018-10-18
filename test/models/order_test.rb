require "test_helper"

describe Order do
  let(:order) { orders(:order_one) }

    describe 'validates' do

      it "must be valid" do
        value(order).must_be :valid?
      end

      it 'has required fields' do
        fields = [:user_id, :address_id, :payment_id, :status]
        fields.each do |field|
          expect(order).must_respond_to field
        end
      end
    end


    describe 'Relationships' do
      it 'can have many products' do

        order.products << products(:lasagne)
        order.products << products(:spaghetti)
        products = order.products

        expect(products.length).must_be :>=, 1
        products.each do |product|
          expect(product).must_be_instance_of Product
        end
      end

      it 'can have many order_products' do

        order.order_products << order_products(:order_one_spaghetti)
        order_products =   order.order_products

        expect(order_products.length).must_be :>=, 1
        order_products.each do |order_product|
          expect(order_product).must_be_instance_of OrderProduct
        end
      end

      it 'can have one payment' do
        payment = order.payment_id
        expect(payment).must_be_instance_of Payment
      end


      it 'can have one address' do
        address = order.address_id
        expect(address).must_be_instance_of Address
      end

      it 'belongs to a user' do
        user = order.user
        expect(user).must_be_instance_of User
        expect(user.id).must_equal order.user_id
      end

    end


    describe 'validations' do
      it 'must have a user' do
        order = orders(:order_one)
        order.user = nil
        order.save

        valid = order.valid?

        expect(valid).must_equal false
        expect(order.errors.messages[:user]).must_equal ["must exist"]
      end

      it 'must have an address' do
        order = orders(:order_one)
        order.address = nil
        order.save

        valid = order.valid?

        expect(valid).must_equal false
        expect(order.errors.messages[:address]).must_equal ["must exist"]
      end

      it 'must have a payment' do
        order = orders(:order_one)
        order.payment = nil
        order.save

        valid = order.valid?

        expect(valid).must_equal false
        expect(order.errors.messages[:payment]).must_equal ["must exist"]
      end

      it 'must have a status' do
        order = orders(:order_one)
        order.status = nil
        order.save

        valid = order.valid?

        expect(valid).must_equal false
        expect(order.errors.messages[:status]).must_equal ["can't be blank"]
      end

    end
  end
