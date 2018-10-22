require "test_helper"

describe Payment do
  let(:payment) { payments(:visa) }

  it "must be valid" do
    value(payment).must_be :valid?
  end

  it 'has required fields' do
    fields = [:user_id, :address_id, :card_type, :card_number, :expiration_date, :cvv]

    fields.each do |field|
      expect(payment).must_respond_to field
    end
  end


  describe 'Relationships' do

    it 'belongs to a user' do
      user = payment.user
      expect(user).must_be_instance_of User
      expect(user.id).must_equal payment.user_id
    end

    # it 'belongs to an order' do
    #   order = payment.order
    #   expect(order).must_be_instance_of Order
    #   expect(order.id).must_equal payment.order_id
    # end

    it 'belongs to an address' do
      address = payment.address
      expect(address).must_be_instance_of Address
      expect(address.id).must_equal payment.address_id
    end


  end

  describe 'validations' do
    it 'must have a user' do
      payment = payments(:amex)
      payment.user = nil
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:user]).must_equal ["must exist"]
    end

    it 'must have an address' do
      payment = payments(:amex)
      payment.address = nil
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:address]).must_equal ["must exist"]
    end

    it 'must have a card_number' do
      payment = payments(:amex)
      payment.card_number = nil
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:card_number]).must_equal ["can't be blank", "is not a number", "is the wrong length (should be 16 characters)"]
    end

    it 'must have a card_number that is 16 integers' do
      payment = payments(:amex)
      payment.card_number = 12309845
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:card_number]).must_equal ["is the wrong length (should be 16 characters)"]
    end

    it 'must have an expiration date' do
      payment = payments(:amex)
      payment.expiration_date = nil
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:expiration_date]).must_equal ["can't be blank"]
    end

    it 'must have a cvv' do
      payment = payments(:amex)
      payment.cvv = nil
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:cvv]).must_equal ["can't be blank", "is not a number","is too short (minimum is 3 characters)"]
    end

    it 'must have a cvv between 3-6 numbers long' do
      payment = payments(:amex)
      payment.cvv = 12
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:cvv]).must_equal ["is too short (minimum is 3 characters)"]

      payment.cvv = 1234567
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:cvv]).must_equal ["is too long (maximum is 6 characters)"]

      payment.cvv = 'abc'
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:cvv]).must_equal ["is not a number","is too short (minimum is 3 characters)"]

    end

    it 'must have a card_type' do
      payment = payments(:amex)
      payment.card_type = nil
      payment.save

      valid = payment.valid?

      expect(valid).must_equal false
      expect(payment.errors.messages[:card_type]).must_equal ["can't be blank"]
    end
  end
end
