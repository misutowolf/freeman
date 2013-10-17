=begin

  * Name: spec/source_buffer_spec.rb
	* Description: SourceBuffer test spec (rspec)
	* Author: Charles "MisutoWolf" Baker
	  * GitHub: https://github.com/misutowolf
	* Date: 10/16/2013
	* License: MIT

=end

require 'rspec'
require_relative '../lib/source_buffer'

describe 'SourceBuffer#new' do

  before :all do
    @buffer = SourceBuffer.new
	end

  it '  - should be an instance of SourceBuffer' do
    @buffer.should be_an_instance_of SourceBuffer
	end

	it '  - should set the buffer given a string' do
	  @buffer.set("Hello")
		@buffer.buffer.should eql "Hello"
  	@buffer.length.should eql 5
    @buffer.position.should eql 0
  end

	it '  - should reset the buffer' do
    @buffer.reset
		@buffer.buffer.should eql ''
		@buffer.length.should eql 0
	  @buffer.position.should eql 0
  end

end
