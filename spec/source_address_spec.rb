require 'rspec'
require 'spec_helper'
require_relative('../lib/source_address')

describe '#new' do

  it ' - should take a valid IPv4 address and return a new SourceAddress' do
    addr = SourceAddress.new('127.0.0.1')
    addr.should be_an_instance_of SourceAddress
    addr.ip.should eql '127.0.0.1'
  end

  it ' - should take a hostname, resolve it, and return a new SourceAddress' do
    addr = SourceAddress.new('localhost')
    addr.hostname.should eql 'localhost'
    addr.ip.should eql '127.0.0.1'
  end

end