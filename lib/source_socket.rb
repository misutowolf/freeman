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

  def initialize(addr,port,buffer)

    addr.is_a?(SourceAddress) ? @addr = addr.ip : ( @addr = nil; puts 'Error: Address argument is wrong type.' )
    port.is_a?(SourcePort) ? @port = port.num : ( @port = nil; puts 'Error: Port argument is wrong type.' )

    # Attach SourceBuffer here
    @buffer = buffer

  end

  def to_s
    "#{@addr}:#{@port}"
  end

  def connect(engine)
    # TODO: Socket connection implementation
  end

end