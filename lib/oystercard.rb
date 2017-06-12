class Oystercard

attr_reader :balance
STARTING_BALANCE = 0

def initialize(balance = STARTING_BALANCE)
@balance = balance
end

def top_up(money)
@balance = money
end
end
