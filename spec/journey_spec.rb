require 'journey'

describe Journey do
  let(:entry_station) { double('Aldgate') }

  describe '#start_journey' do
    it { is_expected.to respond_to(:start_journey).with(1).argument}

    it 'records the name of the entry station' do
      allow(entry_station).to receive(:name).and_return('Aldgate')
      expect { subject.start_journey(entry_station) }.to change { subject.entry_station }.from(nil).to('Aldgate')
    end
  end
end
