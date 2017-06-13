class Oystercard

attr_accessor :balance

MAX_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(money)
    @balance += money
    raise "Balance £#{@balance}, Limit exceeded" if @balance >= MAX_BALANCE
  end

end
