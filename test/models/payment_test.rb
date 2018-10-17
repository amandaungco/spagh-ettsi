require "test_helper"

describe Payment do
  let(:payment) { Payment.new }

  it "must be valid" do
    value(payment).must_be :valid?
  end
end
