require "test_helper"

describe OrderProduct do
  let(:order_product) { order_products(:order_one_spaghetti) }
  it "must be valid" do
   value(order_product).must_be :valid?
 end
  it 'has required fields' do
   fields = [:order, :product, :quantity]
    fields.each do |field|
     expect(order_product).must_respond_to field
   end
 end
  describe 'Relationships' do
    it 'belongs to an order' do
     order = order_product.order
     expect(order).must_be_instance_of Order
     expect(order.id).must_equal order_product.order_id
   end
    it 'belongs to a product' do
     product = order_product.product
     expect(product).must_be_instance_of Product
     expect(product.id).must_equal order_product.product_id
   end
  end
  describe 'validations' do
   it 'must have an order' do
     order_product = order_products(:order_one_spaghetti)
     order_product.order = nil
     order_product.save
      valid = order_product.valid?
      expect(valid).must_equal false
     expect(order_product.errors.messages[:order]).must_equal ["must exist", "can't be blank"]
   end
    it 'must have aa product' do
     order_product = order_products(:order_one_spaghetti)
     order_product.product = nil
     order_product.save
      valid = order_product.valid?
      expect(valid).must_equal false
     expect(order_product.errors.messages[:product]).must_equal ["must exist", "can't be blank"]
   end
    it 'must have an quantity' do
     order_product = order_products(:order_one_spaghetti)
     order_product.quantity = nil
     order_product.save
      valid = order_product.valid?
      expect(valid).must_equal false
     expect(order_product.errors.messages[:quantity]).must_equal ["can't be blank", "is not a number"]
   end
 end

 describe 'item_subtotal method' do
   it 'returns the price of the item times the quantity in the cart' do
     order_product = order_products(:order_one_spaghetti)
     item = products(:spaghetti)

     expect(order_product.item_subtotal).must_equal (5 * 299)

   end

 end
end
