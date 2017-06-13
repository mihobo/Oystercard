# lib/oystercard.rb
class Oystercard
  attr_accessor :balance, :money
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE, in_journey = false)
    @balance = balance
    @in_journey = in_journey
  end

  def top_up(money)
    raise "Exceeded #{MAX_LIMIT} limit" if @balance + money >= MAX_LIMIT
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    min_amount
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def min_amount
    fail 'Please top up at least £1' if @balance < 1

  end
end
