
class Oystercard
  attr_reader :balance, :journey

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MAX_ERROR = "Cannot top up over maximum balance of £#{MAXIMUM_BALANCE}".freeze

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = false
  end

  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end
  
  def in_journey?
    journey
  end

  def top_up(amount)
    raise MAX_ERROR if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
