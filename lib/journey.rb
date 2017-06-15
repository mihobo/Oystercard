require 'station'

class Journey
  attr_reader :entry_station

  def initialize
    @entry_station = nil
  end

  def start_journey(station)
    @entry_station = station.name
  end
end
