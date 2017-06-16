# lib/oystercard.rb
require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journey_history
  DEFAULT_BALANCE = 0
  MAX_LIMIT       = 90
  MIN_FARE        = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @current_startpoint = nil
    @current_endpoint = nil
    @journey_history = []
  end

  def current_startpoint
    @current_startpoint
  end

  def current_endpoint
    @current_endpoint
  end

  def top_up(money)
    raise "Exceeded #{MAX_LIMIT} limit" if @balance + money >= MAX_LIMIT
    @balance += money
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station, journey)
    raise "Please top up at least £#{MIN_FARE}" if @balance < MIN_FARE.to_i
    check_in(station, journey)
  end

  def check_in(station, journey)
    journey.start_at(station)
    penalty?(journey)
    @current_startpoint = station
  end

  def penalty?(journey)
    !@current_startpoint.nil? ? (record_journey; deduct(journey.fare)) : nil
  end

  def touch_out(station, journey)
    journey.finish_at(station)
    deduct(journey.fare)
    @current_endpoint = station
    record_journey
  end

  def view_journey_history
    @journey_history
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def record_journey
    @journey_history << { entry: @current_startpoint, exit: @current_endpoint }
    @current_startpoint = nil
    @current_endpoint = nil
  end
end
