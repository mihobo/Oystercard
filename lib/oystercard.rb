# lib/oystercard.rb
class Oystercard
  attr_reader :balance, :money
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    raise "Exceeded #{MAX_LIMIT} limit" if @balance + money >= MAX_LIMIT
    @balance += money
  end
end
