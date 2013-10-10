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