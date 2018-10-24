require "test_helper"

describe OrdersController do
  let(:order_one) {orders(:order_one)}

  describe 'show' do
    it 'shows the order' do
      get order_path(order_one.id)

      must_respond_with :success
    end
  end

  describe 'create' do
  end

  describe 'edit' do
  end

  describe 'mark_as_shipped' do
  end

  describe 'update'  do
  end




end
