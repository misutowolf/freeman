=begin

  * Name: spec/source_socket_spec.rb
  * Description: SourceSocket test spec for Freeman.
  * Author: Charles "MisutoWolf" Baker
    * GitHub: https://github.com/misutowolf
  * Date: 10/11/2013
  * License: MIT

=end

require 'rspec'
require_relative '../lib/source_socket'
require_relative '../lib/source_buffer'

describe 'SourceSocket#new' do

  before(:all) do
	  @addr = SourceAddress.new '127.0.0.1'
	  @port = SourcePort.new 27016
	  @buffer = SourceBuffer.new
	  @sock = SourceSocket.new @addr, @port, @buffer
  end

  it '  - should take a SourceAddress, SourcePort, and SourceBuffer object as parameters, returning a SourceSocket object' do
    @sock.addr.should eql '127.0.0.1'
    @sock.port.should eql 27016
		@sock.buffer.should be_an_instance_of SourceBuffer
  end

  it '  - should output "address:port" when printed as a string' do
    @sock.to_s.should eql '127.0.0.1:27016'
  end

end
