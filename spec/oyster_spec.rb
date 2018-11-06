require 'oyster'

describe Oystercard do
  context '#top_up' do
    it 'should be able to be topped up with an amount' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it 'should not be possible top up over the maximum balance' do
      max = Oystercard::MAXIMUM_BALANCE
      error = Oystercard::MAX_ERROR
      expect { subject.top_up(max + 5) }.to raise_error(RuntimeError, error)
    end
  end
  
  context '#deduct' do
    
    it 'should be able to deduct an amount from the balance' do
      subject.top_up(20)
      expect(subject.deduct(5)).to eq 15
    end

  end

end
