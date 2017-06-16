# lib/journey.rb
class Journey
  attr_reader :entry_station, :exit_station
  STD_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start_at(station)
    @entry_station = station.name
  end

  def finish_at(station)
    @exit_station = station.name
  end

  def complete?
    !!entry_station && exit_station
  end

  def fare
    complete? ? STD_FARE : PENALTY_FARE
  end
end
