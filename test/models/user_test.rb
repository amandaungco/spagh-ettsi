require "test_helper"

describe User do
  let(:user) { User.new(first_name: 'Chris', last_name: 'McNally', email: 'chris@ada.com', uid:'12345', provider: 'github') }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it 'has required fields' do
    fields = [:first_name, :last_name, :email, :uid, :provider]

    fields.each do |field|
      expect(user).must_respond_to field
    end
  end
end

describe 'Relationships' do
  let(:user) { User.new(first_name: 'Chris', last_name: 'McNally', email: 'chris@ada.com', uid:'12345', provider: 'github') }

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

# describe 'validations' do
#   it 'must have a title' do
#     # Arrange
#     work = works(:harrypotter)
#     work.title = nil
#     work.save
#
#
#     # Act
#     valid = work.valid?
#
#
#     # Assert
#     expect(valid).must_equal false
#     expect(work.errors.messages).must_include :title
#     expect(work.errors.messages[:title]).must_equal ["can't be blank"]
#   end
#
#   it 'must have a publication_year with a 4 integers' do
#     work.publication_year = 0
#     # Arrange
#     work.publication_year += 999
#
#     # Act
#     valid = work.valid?
#
#     # Assert
#     expect(valid).must_equal false
#     expect(work.errors.messages).must_include :publication_year
#
#
#     work.publication_year += 100
#     valid = work.valid?
#     expect(valid).must_equal true
#   end
#
#   it 'requires a unique title and category' do
#     #other_book = book.clone
#     poodr = works(:poodrbook)
#
#
#     valid = poodr.valid?
#
#     expect(valid).must_equal true
#
#     poodr.category = 'movie'
#     valid = poodr.valid?
#     expect(valid).must_equal false
#     expect(poodr.errors.messages).must_include :title
