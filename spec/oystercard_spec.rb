require 'oystercard.rb'

describe Oystercard do
  it { is_expected.to respond_to :balance }

  it { is_expected.to respond_to(:top_up).with(1).argument }

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


  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deduct money from the oystercard balance' do
      oystercard = Oystercard.new(50)
      expect(oystercard.deduct(20)).to eq 30
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it 'returns false when customer is not travelling' do
    oystercard = Oystercard.new(1)
    expect(oystercard.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it 'returns true when customer touches in' do
      oystercard = Oystercard.new(2)
      expect(oystercard.touch_in).to eq true
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it 'returns false when customer touches out' do
      oystercard = Oystercard.new
      expect(oystercard.touch_out).to eq false
    end
  end

  describe '#min_amount' do
    it { is_expected.to respond_to(:min_amount)}

    it 'raises an error if the balance is less than £1' do
      oystercard = Oystercard.new
      expect { oystercard.min_amount }.to raise_error('Please top up at least £1')
    end
  end

end
