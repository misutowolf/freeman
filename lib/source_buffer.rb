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

  # TODO: Implement buffer that will deal with SourceSocket.



  # TODO: Methods that need to be implemeneted:
  #
  #   * set(buffer) - Takes SourceBuffer object
  #   * reset()
  #   * remaining_bytes()
  #   * get(length) - Takes amount of bytes to get from buffer.

  #   SPECIFIC DATA TYPES (unpack from front of buffer)
  #   * get_byte()  - Gets first byte from buffer.
  #   * get_short() - Gets two bytes from buffer
  #   * get_float() - Gets four bytes from buffer (Floating decimal)
  #   * get_ulong() - Gets four bytes from buffer (Unsigned Long Integer)
  #   * get_string() - Gets a null-terminated string from buffer.  Will require a loop (can't unpack this!)

  # Set the buffer!
  def set(buffer)
    @buffer = buffer
    @length = buffer.length
    @position = 0
  end



  def reset
    @buffer = ''
    @length = 0
    @position = 0
  end



  def get_remaining_bytes
    @length-@position
  end



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



  def get_byte
    get(1).ord
  end



  def get_short
    get(2).unpack('s')
  end


  # TODO:  Resume, starting with get_float()

end