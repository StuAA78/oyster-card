require 'oyster'

describe Oystercard do

  it "should have a balance of zero when created" do
    expect(subject.balance).to eq 0
  end

  it "should be able to be topped up with an amount" do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

end
