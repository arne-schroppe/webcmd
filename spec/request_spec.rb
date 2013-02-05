require 'src/request'
require 'rubygems'
require 'rspec'


describe Request do

  it "stores the command" do
    request = Request.new "wp Charles Babbage"
    request.command.should eq "wp"
  end

  it "stores the arguments" do
    request = Request.new "wp Alan Turing"
    request.arguments.should eq "Alan Turing"
  end

  it "strips white space" do
    request = Request.new "  wp    Ada Lovelace     "

    request.command.should eq "wp"
    request.arguments.should eq "Ada Lovelace"
  end
  
end
