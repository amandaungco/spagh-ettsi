require "test_helper"

describe Review do
  let(:review) { Review.new(user_id: 1, rating:3, review: 'cool') }

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
  let(:review) { Review.new(user_id: 1, product_id:2, rating:3) }

  it 'can have one product' do

    review.product_id = Product.first.id
    product = Product.find(review.product_id)
    expect(product).must_be_instance_of Product
  end

#   it 'can have many orders' do
#
#     user.orders << Order.first
#     orders = user.orders
#
#     expect(orders.length).must_be :>=, 1
#     orders.each do |order|
#       expect(order).must_be_instance_of Order
#     end
#   end
#
#   it 'can have many addresses' do
#
#     user.addresses << Address.first
#     addresses = user.addresses
#
#     expect(addresses.length).must_be :>=, 1
#     addresses.each do |address|
#       expect(address).must_be_instance_of Address
#     end
#   end
#
#   it 'can have many payments' do
#
#     user.payments << Payment.first
#     payments = user.payments
#
#     expect(payments.length).must_be :>=, 1
#     payments.each do |payment|
#       expect(payment).must_be_instance_of Payment
#     end
#   end
#
#   it 'can have many reviews' do
#
#     user.reviews << Review.first
#     reviews = user.reviews
#
#     expect(reviews.length).must_be :>=, 1
#     reviews.each do |review|
#       expect(review).must_be_instance_of Review
#     end
#   end
# end
#
# describe 'validations' do
#   it 'must have a first_name' do
#     user = users(:hannah)
#     user.first_name = nil
#     user.save
#
#     valid = user.valid?
#
#     expect(valid).must_equal false
#     expect(user.errors.messages).must_include :first_name
#   end
#
#   it 'must have a last_name' do
#     user = users(:hannah)
#     user.last_name = nil
#     user.save
#
#     valid = user.valid?
#
#     expect(valid).must_equal false
#     expect(user.errors.messages).must_include :last_name
#   end
#
#   it 'must have an email' do
#     user = users(:hannah)
#     user.email = nil
#     user.save
#
#     valid = user.valid?
#
#     expect(valid).must_equal false
#     expect(user.errors.messages).must_include :email
#   end
#
#   it 'must have a uid' do
#     user = User.first
#     user.uid = nil
#     user.save
#
#     valid = user.valid?
#
#     expect(valid).must_equal false
#     expect(user.errors.messages).must_include :uid
#   end
#
#   it 'must have a provider' do
#     user = users(:hannah)
#     user.provider = nil
#     user.save
#
#     valid = user.valid?
#
#     expect(valid).must_equal false
#     expect(user.errors.messages).must_include :provider
#   end
end
