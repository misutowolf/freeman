=begin

  * Name: spec/source_port_spec.rb
  * Description: SourcePort test spec for Freeman.
  * Author: Charles "MisutoWolf" Baker
    * GitHub: https://github.com/misutowolf
  * Date: 10/11/2013
  * License: MIT

=end

require 'rspec'
require_relative '../lib/source_port'

describe 'SourcePort#new' do

  it '  - should take a valid number and return a SourcePort object' do
    @port = SourcePort.new 27016
    @port.should be_an_instance_of SourcePort
    @port.num.should eql 27016
  end

  it '  - should take a non-Integer and return a SourcePort object with fallback number' do
    @port = SourcePort.new 'test'
    @port.should be_an_instance_of SourcePort
    @port.num.should eql 27015
  end

  it '  - should take a negative Integer and return a SourcePort object with fallback number' do
    @port = SourcePort.new -5
    @port.should be_an_instance_of SourcePort
    @port.num.should eql 27015
  end

end