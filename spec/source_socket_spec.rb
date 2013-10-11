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

describe 'SourceSocket#new' do

  it '  - should take a SourceAddress and SourcePort object as parameters, returning a SourceSocket object' do
    @addr = SourceAddress.new '127.0.0.1'
    @port = SourcePort.new 27016
    @sock = SourceSocket.new @addr, @port
    @sock.addr.should eql '127.0.0.1'
    @sock.port.should eql 27016
  end

  it '  - should output "address:port" when printed as a string' do
    @addr = SourceAddress.new '127.0.0.1'
    @port = SourcePort.new 27017
    @sock = SourceSocket.new @addr, @port
    @sock.to_s.should eql '127.0.0.1:27017'
  end

end