require 'oystercard.rb'

describe Oystercard do
  describe 'oystercard creation' do
    it 'starts off a new oystercard with no station' do
      expect(subject.entry_station).to eq nil
    end
  end

  describe '#top_up' do
    it 'adds money to the oystercard balance' do
      oystercard = Oystercard.new(10)
      expect(oystercard.top_up(9)).to eq 19
    end

    it 'doesn\'t allow to top up beyond the limit' do
      oystercard = Oystercard.new(20)
      expect { oystercard.top_up(80) }.to raise_error("Exceeded #{Oystercard::MAX_LIMIT} limit")
    end
  end

  describe '#in_journey?' do
    it 'returns false when customer is not travelling' do
    oystercard = Oystercard.new(1)
    expect(oystercard.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    xit 'returns true when customer touches in' do
      oystercard = Oystercard.new(2)
      expect(oystercard.touch_in).to eq true
    end

    xit 'raises an error if the balance is less than £1' do
      oystercard = Oystercard.new
      expect { oystercard.touch_in }.to raise_error("Please top up at least £#{Oystercard::MIN_FARE}")
    end

    it 'returns the station name where you touch in' do
      oystercard = Oystercard.new(5)
      station = double("Aldgate")
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it 'returns false when customer touches out' do
      oystercard = Oystercard.new
      expect(oystercard.touch_out).to eq false
    end

    it 'deducts correct amount when journey\'s complete' do
      oystercard = Oystercard.new(20)
      expect{oystercard.touch_out}.to change{oystercard.balance}.by(-1)
    end
  end
end
