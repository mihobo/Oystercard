require 'station'

describe Station do
  let(:station)  { described_class.new('Holborn', 1) }

  describe 'station creation' do
    it 'gives the station name' do
      expect(station.name).to eq 'Holborn'
    end

    it 'gives the zone' do
      expect(station.zone).to eq 1
    end
  end
end
