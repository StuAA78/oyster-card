require 'oyster'

describe Oystercard do
  describe '#top_up' do
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
  
  describe '#deduct' do
    
    it 'should be able to deduct an amount from the balance' do
      subject.top_up(20)
      expect(subject.deduct(5)).to eq 15
    end

  end

  describe 'touch_in' do

    it 'should be able to touch in and start journey' do
      subject.touch_in
      expect(subject.journey).to eq true
    end

  end

  describe 'touch_out' do

    it 'should be able to touch out and stop journey' do
      subject.touch_in
      subject.touch_out
      expect(subject.journey).to eq false
    end

  end
  
  describe 'in_journey?' do
        context 'tapped in' do
            it 'journey should be reported as true' do
                subject.touch_in
                expect(subject.in_journey?).to eq true
            end
        end

        context 'tapped out' do
            it 'journey should be reported as false' do
                subject.touch_in
                subject.touch_out
                expect(subject.in_journey?).to eq false
            end
        end
  end

end
