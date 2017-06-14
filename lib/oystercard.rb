# lib/oystercard.rb
class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history
  DEFAULT_BALANCE = 0
  MAX_LIMIT       = 90
  MIN_FARE        = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance          = balance
    @current_journey  = {}
    @journey_history  = []
  end

  def top_up(money)
    raise "Exceeded #{MAX_LIMIT} limit" if @balance + money >= MAX_LIMIT
    @balance += money
  end

  def in_journey?
    !!@entry_station
  end

  def entry_station
    @current_journey[:entry]
  end

  def touch_in(station)
    fail "Please top up at least £#{MIN_FARE}" if @balance < 1
    @entry_station = station

  end

  def exit_station
    @current_journey[:exit]
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    record_journey
    @entry_station = nil
  end

  def view_journey_history
    @journey_history
  end

  private

  def deduct(min_fare)
    @balance -= MIN_FARE
  end

  def record_journey_start(station)
    current_journey[:entry] = station
  end

  def record_journey_end(station)
    current_journey[:exit] = station
  end

  def record_complete_journey
    @journey_history << @current_journey
  end
end
