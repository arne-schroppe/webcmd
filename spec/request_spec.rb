require 'src/request'
require 'rubygems'
require 'rspec'


describe Request do

  it "stores the command" do
    request = Request.from_string "wp Charles Babbage"
    request.command.should eq "wp"
  end

  it "stores the arguments" do
    request = Request.from_string "wp Alan Turing"
    request.arguments.should eq "Alan Turing"
  end

  it "strips white space" do
    request = Request.from_string "  wp    Ada Lovelace     "

    request.command.should eq "wp"
    request.arguments.should eq "Ada Lovelace"
  end

  it "can handle commands without arguments" do
    request = Request.from_string " c2 "

    request.command.should eq "c2"
    request.arguments.should eq ""
  end

  it "resolves the namespace of an argument" do
    request = Request.from_string "paamuk:stop argument1 argument2"

    request.command.should eq "stop"
    request.arguments.should eq "argument1 argument2"
    request.namespace.should eq "paamuk"
  end

  it "uses 'user' as the default namespace" do
    request = Request.from_string "wp Alan Turing"
    request.namespace.should eq "user"
    request.command.should eq "wp"
    request.arguments.should eq "Alan Turing"
  end
  
end
