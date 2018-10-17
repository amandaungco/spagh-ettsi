require "test_helper"

describe Address do
  let(:address) { Address.new }

  it "must be valid" do
    value(address).must_be :valid?
  end
end
