require 'oystercard.rb'
require 'journey'
require 'station'

describe Oystercard do
  let(:card) { described_class.new(min_fare) }
  let(:max_limit) { described_class::MAX_LIMIT }
  let(:min_fare) { described_class::MIN_FARE }
  let(:journey) { double('Journey') }
  let(:entry_station) { double('Aldgate') }
  let(:exit_station) { double('Waterloo') }

  describe 'oystercard creation' do
    it 'starts off a new oystercard with no station' do
      expect(card.current_startpoint).to eq nil
    end

    describe '#journey_history' do
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

  describe '#touch_in' do
    context 'Touching in at a station' do
      let(:empty_card) { described_class.new }

      it 'raises an error if the balance is less than £1' do
        expect { empty_card.touch_in(entry_station, journey) }.to raise_error("Please top up at least £#{min_fare}")
      end

      context 'when someone has touched in but not out' do
        before do
          allow(entry_station).to receive(:entry_station).and_return('Aldgate')
          allow(journey).to receive(:entry_station).and_return('Aldgate')
          allow(journey).to receive(:start_at).with(entry_station)
        end

        it 'charges a penalty fare' do
          station = Station.new('home', 1)
          trip = Journey.new
          allow(journey).to receive(:fare)
          card.touch_in(station, trip)
          expect { card.touch_in(station, trip) }.to change { card.balance }.from(1).to(-5)
        end
      end
    end
  end

  describe '#touch_out' do
    context 'When touching out' do
      before do
        allow(journey).to receive(:entry_station).and_return(nil)
        allow(journey).to receive(:exit_station).and_return(nil)
        station = Station.new('home', 1)
        trip = Journey.new
        card.touch_in(station, trip)
        card.touch_out(station, trip)
      end

      it 'deducts correct amount when journey\'s complete' do
        expect(card.balance).to eq 0
      end
    end
  end

  describe '#view_journey_history' do
    it 'shows journey history' do
      home = Station.new('home', 1)
      school = Station.new('school', 2)
      trip = Journey.new
      card.touch_in(home, trip)
      card.touch_out(school, trip)
      expect(card.view_journey_history).to eq [{ entry: home, exit: school }]
    end
  end
end
