require "test_helper"

describe Address do
  let(:address) { addresses(:home) }

  it "must be valid" do
    value(address).must_be :valid?
  end

  it 'has required fields' do
    fields = [:user_id, :first_name, :last_name, :street, :city, :state, :zip]

    fields.each do |field|
      expect(address).must_respond_to field
    end
  end


  describe 'Relationships' do

    it 'belongs to a user' do
      user = address.user
      expect(user).must_be_instance_of User
      expect(user.id).must_equal address.user_id
    end


    it 'has one user' do
      user = address.user
      expect(user).must_be_instance_of User
    end


  end

  describe 'validations' do
    it 'must have a user' do
      address = addresses(:home)
      address.user = nil
      address.save

      valid = address.valid?

      expect(valid).must_equal false
      expect(address.errors.messages[:user]).must_equal ["must exist"]
    end

    it 'must have a first_name' do
      address = addresses(:home)
      address.first_name = nil
      address.save

      valid = address.valid?

      expect(valid).must_equal false
      expect(address.errors.messages[:first_name]).must_equal ["can't be blank"]
    end

    it 'must have a last_name' do
      address = addresses(:home)
      address.last_name = nil
      address.save

      valid = address.valid?

      expect(valid).must_equal false
      expect(address.errors.messages[:last_name]).must_equal ["can't be blank"]
    end
    it 'must have a street' do
      address = addresses(:home)
      address.street = nil
      address.save

      valid = address.valid?

      expect(valid).must_equal false
      expect(address.errors.messages[:street]).must_equal ["can't be blank"]
    end
    it 'must have a city' do
      address = addresses(:home)
      address.city = nil
      address.save

      valid = address.valid?

      expect(valid).must_equal false
      expect(address.errors.messages[:city]).must_equal ["can't be blank"]
    end

    it 'must have a state' do
      address = addresses(:home)
      address.state = nil
      address.save

      valid = address.valid?

      expect(valid).must_equal false
      expect(address.errors.messages[:state]).must_equal ["can't be blank"]
    end

    it 'must have a zip' do
      address = addresses(:home)
      address.zip = nil
      address.save

      valid = address.valid?

      expect(valid).must_equal false
      expect(address.errors.messages[:zip]).must_equal ["can't be blank", "is not a number"]
    end

    it 'must have a zip that is numerical' do
      address = addresses(:home)
      address.zip = 'abced'
      address.save

      valid = address.valid?

      expect(valid).must_equal false
      expect(address.errors.messages[:zip]).must_equal ["is not a number"]
    end
  end
end
