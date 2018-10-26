require "test_helper"

describe Product do
  let(:product) { products(:spaghetti) }

  it "knows its own categories" do
    expect(Product.categories).must_equal ['long', 'short', 'shell', 'sheet', 'filled', 'soup']
  end

  it "can filter only active products" do
    expect(Product.active_products.count).must_equal 3
    expect(Product.active_products).wont_include products(:inactive_ravioli)
  end

  it "returns an empty set with no active products" do
    Product.all.each do |product|
      product.is_active = false
      product.save
    end

    expect(Product.active_products.count).must_equal 0
  end

  it "knows its average_rating " do
    expect(product.average_rating).must_equal 3
  end

  it "returns not yet rated if there are no ratings" do
    expect(products(:fusilli).average_rating).must_equal 'Not yet rated'
  end

  it "must be valid" do
    value(product).must_be :valid?
  end

  it 'has required fields' do
    fields = [:user_id, :name, :price_in_cents, :quantity, :category, :description]

    fields.each do |field|
      expect(product).must_respond_to field
    end
  end


  describe 'Relationships' do

    it 'can have many reviews' do
      reviews = product.reviews


      expect(reviews.length).must_be :>=, 1
      reviews.each do |review|
        expect(review).must_be_instance_of Review
      end
    end

    it 'can have many orders' do
      orders = product.orders

      expect(orders.length).must_be :>=, 1
      orders.each do |order|
        expect(order).must_be_instance_of Order
      end
    end

    it 'can have many order_products' do
      OrderProduct.create(order: orders(:order_one), product: products(:spaghetti), quantity: 5)
      order_products = product.order_products

      expect(order_products.length).must_be :>=, 2
      order_products.each do |order_product|
        expect(order_product).must_be_instance_of OrderProduct
      end
    end

    it 'belongs to a user' do
      user = product.user
      expect(user).must_be_instance_of User
      expect(user.id).must_equal product.user_id
    end

  end

  describe 'validations' do
    it 'must have a user' do
      product = products(:lasagne)
      product.user = nil
      product.save

      valid = product.valid?

      expect(valid).must_equal false
      expect(product.errors.messages[:user]).must_equal ["must exist"]
    end

    it 'must have a name' do
      product = products(:lasagne)
      product.name = nil
      product.save

      valid = product.valid?

      expect(valid).must_equal false
      expect(product.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it 'must have an price_in_cents' do
      product = products(:lasagne)
      product.price_in_cents = nil
      product.save

      valid = product.valid?

      expect(valid).must_equal false
     expect(product.errors.messages[:price_in_cents]).must_equal ["can't be blank", "Price must be greater than 0"]
    end

    it 'must have a quantity' do
      product = products(:lasagne)
      product.quantity = nil
      product.save

      valid = product.valid?

      expect(valid).must_equal false
      expect(product.errors.messages[:quantity]).must_equal ["can't be blank", "Stock cannot go below 0"]
    end

    it 'must have a category' do
      product = products(:lasagne)
      product.category = nil
      product.save

      valid = product.valid?

      expect(valid).must_equal false
      expect(product.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it 'must have an description' do
      product = products(:lasagne)
      product.description = nil
      product.save

      valid = product.valid?

      expect(valid).must_equal false
      expect(product.errors.messages[:description]).must_equal ["can't be blank"]
    end
  end
end
