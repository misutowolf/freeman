class SourcePort

  attr_accessor :num

  def initialize(num=27015)

    # If invalid value for port number is given (non-Integer), set to fallback (27015)
    begin
      !!Integer(num)
    rescue ArgumentError, TypeError
      num=27015
    end

    # If the value is out of range (negative), set to fallback, as well.
    if num <= 0
      @num = 27015
    else
      @num = num
    end

  end

end