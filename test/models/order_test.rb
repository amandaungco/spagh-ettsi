require "test_helper"

describe Order do
  let(:order) { orders(:order_one) }

  describe 'validates' do

    it "must be valid" do
      value(order).must_be :valid?
    end

    it 'has required fields' do
      fields = [:user_id, :status]
      fields.each do |field|
        expect(order).must_respond_to field
      end
    end

  end


  describe 'Relationships' do
    it 'can have many products' do

      products = order.products
      expect(products.length).must_be :>=, 1
      products.each do |product|
        expect(product).must_be_instance_of Product
      end
    end

    it 'can have many order_products' do
      OrderProduct.create(order: order, product: products(:lasagne), quantity: 5)

      order_products = order.order_products
      expect(order_products.length).must_be :>=, 2
      order_products.each do |order_product|
        expect(order_product).must_be_instance_of OrderProduct
      end
    end

    it 'can have one payment' do
      payment = order.payment
      expect(payment).must_be_instance_of Payment
    end

    it 'can have one address' do
      address = order.address
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


    it 'must have a status' do
      order = orders(:order_one)
      order.status = nil
      order.save

      valid = order.valid?

      expect(valid).must_equal false
      expect(order.errors.messages[:status]).must_equal ["can't be blank"]
    end

  end


  describe "custom validations" do
    let(:placed_order) { orders(:order_two) }

    describe "validations for a :placed_order" do
      it "placed_order will work if it has a payment and address'" do

        placed_order.save

        valid = placed_order.valid?

        expect(valid).must_equal true
      end

      it 'will not work if it does not have a payment' do
        placed_order.payment = nil
        placed_order.save

        valid = placed_order.valid?
        expect(valid).must_equal false
  
      end

      it 'will not work if it does not have an address' do
        placed_order.address = nil
        placed_order.save

        valid = placed_order.valid?
        expect(valid).must_equal false
      end

    end

  end

end



#change these tests to match custom validation
# it 'must have an address' do
#   order = orders(:order_one)
#   order.address = nil
#   order.save
#
#   valid = order.valid?
#
#   expect(valid).must_equal false
#   expect(order.errors.messages[:address]).must_equal ["must exist"]
# end

# it 'must have a payment' do
#   order = orders(:order_one)
#   order.payment = nil
#   order.save
#
#   valid = order.valid?
#
#   expect(valid).must_equal false
#   expect(order.errors.messages[:payment]).must_equal ["must exist"]
# end
