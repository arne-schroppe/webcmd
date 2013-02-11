require_relative '../src/user_command'
require_relative '../src/request'
require_relative '../src/command_file'
require 'rubygems'
require 'rspec'
require 'webrick'


describe UserCommand do

  before do
    @user_command = described_class.new
    @response = double("response")
    @redirection = WEBrick::HTTPStatus::TemporaryRedirect
  end


  it "resolves a command to a url" do
    CommandFile.stub(:commands).and_return({ "g" => "http://www.google.com" })
    request = Request.new("", "g", "")
    @response.should_receive(:set_redirect).with(@redirection, "http://www.google.com")
    @user_command.resolve(request, @response)
  end


  it "substitutes parameters in the url" do
    CommandFile.stub(:commands).and_return({ "c2" => "http://c2.com/cgi/wiki?search=%s" })
    request = Request.new("", "c2", "AlanKaysReadingList")
    @response.should_receive(:set_redirect).with(@redirection, "http://c2.com/cgi/wiki?search=AlanKaysReadingList")
    @user_command.resolve(request, @response)
  end


  it "replaces spaces with + signs in command arguments" do
    CommandFile.stub(:commands).and_return({ "wp" => "http://en.wikipedia.com/?search=%s" })
    request = Request.new("", "wp", "Centroidal Voronoi tessellation")
    @response.should_receive(:set_redirect).with(@redirection, "http://en.wikipedia.com/?search=Centroidal+Voronoi+tessellation")
    @user_command.resolve(request, @response) 
  end

  it "encodes characters" do
    CommandFile.stub(:commands).and_return({ "am" => "http://www.amazon.com/s/?field-keywords=%s" })
    request = Request.new("", "am", '"smalltalk" ?/#^:')
    @response.should_receive(:set_redirect).with(@redirection, "http://www.amazon.com/s/?field-keywords=%22smalltalk%22+%3F%2F%23%5E%3A")
    @user_command.resolve(request, @response)
  end

end
