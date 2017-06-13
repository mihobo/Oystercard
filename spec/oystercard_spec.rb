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

  it { is_expected.to respond_to(:deduct).with(1).argument }

  describe '#deduct' do
    it 'deduct money from the oystercard balance' do
      oystercard = Oystercard.new(50)
      expect(oystercard.deduct(20)).to eq 30
    end
  end
end
