=begin

  * Name: lib/source_buffer.rb
  * Description: SourceBuffer object for Freeman.
  * Author: Charles "MisutoWolf" Baker
    * GitHub: https://github.com/misutowolf
  * Date: 10/11/2013
  * License: MIT

=end

class SourceBuffer

  # Accessors
  attr_accessor :buffer, :length, :position

  # Set contents of buffer
  def set(buffer)
    @buffer = buffer.encode('binary')
    @length = buffer.length
    @position = 0
  end

  # Reset buffer (empty), set length/position to zero.
  def reset
    @buffer = ''
    @length = 0
    @position = 0
  end

  # Returns number of bytes remaining in buffer to read
  def get_remaining_bytes
    @length-@position
  end

  # Get data from buffer (number of bytes specified).
  def get(length=-1)

    if length == 0
      ''
    end

    remaining = get_remaining_bytes

    if length == -1
      length=remaining
    elsif length > remaining
      ''
    end

    data = @buffer[@position,length]
    @position+=length
    data

  end

  # Get a single byte from the buffer.
  def get_byte
    get(1).ord
  end

  # Get a 16-bit unsigned integer from the buffer.
  def get_short
    get(2).unpack('s')
  end

  # Get a 32-bit floating-point from the buffer.
  def get_float
    get(4).unpack('f')
  end

  # Get a 32-bit signed integer (long) from the buffer.
  def get_long
    get(4).unpack('l')
  end

  # Get a 32-bit unsigned integer (long) from the buffer
  def get_ulong
    get(4).unpack('L')
  end

  # Get a null ('/0') terminated string from the buffer.
  def get_string

    zero_byte = @buffer.index('\0',@position)

    if zero_byte == nil
      string = ''
    else
      string = get(zero_byte-@position)
      @position+=2
    end

    string

  end

end