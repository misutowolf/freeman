=begin

  * Name: lib/source_socket.rb
  * Description: SourceSocket object for Freeman.
  * Author: Charles "MisutoWolf" Baker
    * GitHub: https://github.com/misutowolf
  * Date: 10/11/2013
  * License: MIT

=end

require 'source_address'
require 'source_port'
require 'socket'
require 'bzip2-ruby'

class SourceSocket

  attr_accessor :addr, :port, :buffer

  # Creates a SourceSocket object, using the SourceAddress/SourcePort objects, and attaching a SourceBuffer
  def initialize(addr,port,buffer)

    addr.is_a?(SourceAddress) ? @addr = addr.ip : ( @addr = nil; puts 'Error: Address argument is wrong type.' )
    port.is_a?(SourcePort) ? @port = port.num : ( @port = nil; puts 'Error: Port argument is wrong type.' )

    # Attach SourceBuffer here
    @buffer = buffer

  end

  # The server's 'string' is server:port format.
  def to_s
    "#{@addr}:#{@port}"
  end

  # Opens a connection to the remote server.
  def open(engine)
    @engine = engine
    @socket = Socket.new Socket::PF_INET, Socket::SOCK_DGRAM
    @socket.connect Socket.pack_sockaddr_in(@port,@addr)
  end

  # Writes a command to the remote server, with header.
  def write(header, string='')
    command = [0xFF, 0xFF, 0xFF, 0xFF, header, string].pack('ccccca*')
    length = command.length
    length === @socket.write(command)
  end

  # Reads data from the remote server connection (1400 bytes at a time)
  def read(length=1400)

    # Get first packet worth of information from the server
    @buffer.set(@socket.recvfrom(length)[0])

    # Check for split packet
    if @buffer.remaining > 0 && @buffer.get_long == -2

      # Create a blank array to hold packets, set a few defaults
      packets = Array.new
      is_compressed = false
      read_more = false

      while read_more && sherlock(length)
        request_id = @buffer.get_long  # This doesn't seem to get used anywhere else.  Oh well.

        # Handle things differently depending on engine being used.
        case @engine
          when GOLDSRC # HL1 Engine
            count_and_number = @buffer.get_byte
            packet_count = count_and_number & 0xF
            packet_number = count_and_number >> 4
          when SOURCE  # HL2 Engine -- Supports Bzip2 compression!
            is_compressed = (request_id & 0x80000000) != 0
            packet_count = @buffer.get_byte
            packet_number = @buffer.get_byte+1
              if is_compressed
                @buffer.get_long # Split size
                packet_checksum = @buffer.get_ulong # CRC32 Checksum
              else
                @buffer.get_short # Split size
              end
        end

        packets[packet_number] = @buffer.get
        read_more = packet_count > packets.length

      end

      buffer = packets.join

      # TODO:  DEAL WITH BZIP2 COMPRESSION HERE.  Require BZ2 capability or not? (Ask in IRC)

    end

  end


  # Will throw us out of the read loop if there's less than four bytes left to read in the socket.
  def sherlock(length)
    data = @socket.recvfrom(length)

    # Check length of data read
    if data.length < 4
      return false
    end

    # Otherwise, set the buffer with the data you read, and read split packet status
    @buffer.set(data)
    return @buffer.get_long == 2

  end

end