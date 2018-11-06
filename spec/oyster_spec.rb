require 'oyster'

describe Oystercard do

  let(:min) {Oystercard::MINIMUM_BALANCE}
  let(:max) {Oystercard::MAXIMUM_BALANCE}

  describe '#top_up' do
    it 'should be able to be topped up with an amount' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it 'should not be possible top up over the maximum balance' do
      error = Oystercard::MAX_ERROR
      expect { subject.top_up(max + 5) }.to raise_error(RuntimeError, error)
    end
  end

  describe 'touch_in' do

    it 'should be able to touch in and start journey' do
      subject.top_up(5)
      subject.touch_in
      expect(subject.journey).to eq true
    end

    context 'when balance is below minimum balance' do
      it 'should not start journey' do
        error = Oystercard::MIN_ERROR
        subject.top_up(min - 0.1)
        expect { subject.touch_in }.to raise_error(RuntimeError, error)
      end
    end

  end

  describe 'touch_out' do

    it 'should be able to touch out and stop journey' do
      subject.top_up(5)
      subject.touch_in
      subject.touch_out
      expect(subject.journey).to eq false
    end

    it 'should deduct minimum fare from balance' do
      subject.top_up(5)
      subject.touch_in
      
      expect { subject.touch_out}.to change { subject.balance}.from(5).to(4)
    end

  end

  describe 'in_journey?' do
    before(:each) do
      subject.top_up(5)
      subject.touch_in
    end
        context 'tapped in' do
            it 'journey should be reported as true' do
                expect(subject.in_journey?).to eq true
            end
        end

        context 'tapped out' do
            it 'journey should be reported as false' do
                subject.touch_out
                expect(subject.in_journey?).to eq false
            end
        end
  end



end
