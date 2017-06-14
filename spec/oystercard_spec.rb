require 'oystercard.rb'

describe Oystercard do
  let(:card)          { described_class.new(min_fare) }
  let(:max_limit)     { described_class::MAX_LIMIT }
  let(:min_fare)      { described_class::MIN_FARE }
  let(:entry_station) { double("Aldgate") }
  let(:exit_station)  { double("Waterloo") }

  describe 'oystercard creation' do
    it 'starts off a new oystercard with no station' do
      expect(card.entry_station).to eq nil
    end

    describe '#journey_history' do
      it 'is an array' do
        expect(card.journey_history).to be_a Array
      end

      it 'starts off empty' do
        expect(card.journey_history).to be_empty
      end
    end
  end

  describe '#top_up' do
    context 'Adding money to the card' do
      it 'adds money to the oystercard balance' do
        expect { card.top_up 10 }.to change { card.balance }.by 10
      end

      it 'doesn\'t allow to top up beyond the limit' do
        expect { card.top_up(max_limit) }.to raise_error("Exceeded #{max_limit} limit")
      end
    end
  end

  describe '#in_journey?' do
    it 'returns false when customer is not travelling' do
      expect(card).to_not be_in_journey
    end

    it 'returns true when the customer is travelling' do
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end
  end

  describe '#touch_in' do
    context "Touching in at a station" do
      let(:empty_card) { described_class.new }

      it 'raises an error if the balance is less than £1' do
        expect { empty_card.touch_in(entry_station) }.to raise_error("Please top up at least £#{min_fare}")
      end

      it 'records the start of the journey' do
        card.touch_in(entry_station)
        expect(card.entry_station).to eq entry_station
      end
    end
  end

  describe '#touch_out' do
    context "When touching out" do
      before do
        card.touch_in(entry_station)
        card.touch_out(exit_station)
      end

      it 'resets the entry station' do
        expect(card.entry_station).to be_nil
      end

      it 'deducts correct amount when journey\'s complete' do
        expect(card.balance).to eq 0
      end
    end
  end

  describe '#view_journey_history' do
    context 'After a complete journey' do
      before do
        card.touch_in(entry_station)
        card.touch_out(exit_station)
      end

      it 'shows journey history' do
        expect(card.view_journey_history).to eq [{entry: entry_station, exit: exit_station}]
      end
    end
  end
end
