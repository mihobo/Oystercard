require 'journey'

describe Journey do
  let(:entry_station) { double('Aldgate') }
  let(:exit_station)  { double('Bank') }
  let(:std_fare)      { described_class::STD_FARE }
  let(:penalty_fare)  { described_class::PENALTY_FARE }
  subject(:journey)   { described_class.new }

  describe '#start_at' do
    it { is_expected.to respond_to(:start_at).with(1).argument }

    it 'records the name of the entry station' do
      allow(entry_station).to receive(:name).and_return('Aldgate')
      expect { subject.start_at(entry_station) }.to change { journey.entry_station }.from(nil).to('Aldgate')
    end
  end

  describe '#finish_at' do
    it { is_expected.to respond_to(:finish_at).with(1).argument }

    it 'records the name of the exit station' do
      allow(exit_station).to receive(:name).and_return('Bank')
      expect { journey.finish_at(exit_station) }.to change { journey.exit_station }.from(nil).to('Bank')
    end
  end

  describe '#complete?' do
    context 'when entry and exit station logged' do
      before do
        allow(exit_station).to receive(:name).and_return('Bank')
        allow(entry_station).to receive(:name).and_return('Aldgate')
        journey.start_at(entry_station)
        journey.finish_at(exit_station)
      end

      it 'returns true' do
        expect(journey).to be_complete
      end
    end

    context 'when entry not logged' do
      before do
        allow(exit_station).to receive(:name).and_return('Bank')
        journey.finish_at(exit_station)
      end

      it 'returns false' do
        expect(journey).not_to be_complete
      end
    end

    context 'when exit not logged' do
      before do
        allow(entry_station).to receive(:name).and_return('Aldgate')
        journey.start_at(entry_station)
      end

      it 'returns false' do
        expect(journey).not_to be_complete
      end
    end
  end

  describe '#fare' do
    context 'when the journey is complete' do
      before do
        allow(exit_station).to receive(:name).and_return('Bank')
        allow(entry_station).to receive(:name).and_return('Aldgate')
        journey.start_at(entry_station)
        journey.finish_at(exit_station)
      end

      it 'returns the standard fare' do
        expect(journey.fare).to eq std_fare
      end
    end

    context 'when the journey is not complete' do
      context 'because no touch in' do
        before do
          allow(exit_station).to receive(:name).and_return('Bank')
          journey.finish_at(exit_station)
        end

        it 'returns a penalty fare' do
          expect(journey.fare).to eq penalty_fare
        end
      end
    end
  end
end
