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
    @buffer.set(@socket.recvfrom(length[0]))

  end



end