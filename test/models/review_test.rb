require "test_helper"

describe Review do
  let(:review) { reviews(:one) }

  describe "validates" do

    it "must be valid" do
      value(review).must_be :valid?
    end

    it 'has required fields' do
      fields = [:user_id, :product_id, :rating]

      fields.each do |field|
        expect(review).must_respond_to field
      end
    end
  end

  describe 'Relationships' do

    it 'can have one product' do
      product = review.product
      expect(product).must_be_instance_of Product
    end


    it 'can have one user' do
      user = review.user
      expect(user).must_be_instance_of User
    end
  end

  describe 'validations' do
    it 'must have a user' do
      review = reviews(:one)
      review.user = nil
      review.save

      valid = review.valid?

      expect(valid).must_equal false
      expect(review.errors.messages[:user]).must_equal ["must exist"]
    end

    it 'must have a product' do
      review = reviews(:one)
      review.product = nil
      review.save

      valid = review.valid?

      expect(valid).must_equal false
      expect(review.errors.messages[:product]).must_equal ["must exist"]

    end

    it 'must have an rating' do
      review = reviews(:one)
      review.rating = nil
      review.save

      valid = review.valid?

      expect(valid).must_equal false
      expect(review.errors.messages[:rating]).must_equal "can't be blank", "Rating must be greater than 0", "We're flattered but this product can
 only be rated out of 5."
    end
  end
end
