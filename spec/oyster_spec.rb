require 'oyster'

describe Oystercard do

  it "should have a balance of zero when created" do 
    expect(subject.balance).to eq 0
  end

end
