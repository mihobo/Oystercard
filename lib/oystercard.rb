# lib/oystercard.rb
class Oystercard
  attr_reader :balance, :entry_station
  DEFAULT_BALANCE = 0
  MAX_LIMIT       = 90
  MIN_FARE        = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance       = balance
    @entry_station = nil
  end

  def top_up(money)
    raise "Exceeded #{MAX_LIMIT} limit" if @balance + money >= MAX_LIMIT
    @balance += money
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "Please top up at least £#{MIN_FARE}" if @balance < 1
    @entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

  private

  def deduct(min_fare)
    @balance -= MIN_FARE
  end

end
