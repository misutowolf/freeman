=begin

  * Name: lib/source_address.rb
  * Description: SourceAddress object for Freeman.
  * Author: Charles "MisutoWolf" Baker
    * GitHub: https://github.com/misutowolf
  * Date: 10/11/2013
  * License: MIT

=end

require 'resolv'

class SourceAddress

  attr_accessor :hostname, :ip

  def initialize(addr)

    if Resolv::IPv4::Regex =~ addr
      @ip=addr
      @hostname=nil
    else
      @ip=Resolv::getaddress(addr)
      @hostname=addr
    end

  end

end