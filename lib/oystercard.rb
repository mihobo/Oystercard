# lib/oystercard.rb
class Oystercard
  attr_reader :balance, :journey_history
  DEFAULT_BALANCE = 0
  MAX_LIMIT       = 90
  MIN_FARE        = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance          = balance
    @current_journey  = {}
    @journey_history  = []
  end

  def entry_station
    @current_journey[:entry]
  end

  def exit_station
    @current_journey[:exit]
  end

  def top_up(money)
    raise "Exceeded #{MAX_LIMIT} limit" if @balance + money >= MAX_LIMIT
    @balance += money
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "Please top up at least £#{MIN_FARE}" if @balance < 1
    record_start(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    record_end(station)
    record_journey
  end

  def view_journey_history
    @journey_history
  end

  private

  def deduct(min_fare)
    @balance -= MIN_FARE
  end

  def record_start(station)
    @current_journey[:entry] = station
  end

  def record_end(station)
    @current_journey[:exit] = station
  end

  def record_journey
    @journey_history << { entry: entry_station, exit: exit_station }
    @current_journey.each_key { |k| @current_journey.delete(k) }
  end
end
