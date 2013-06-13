require_relative '../src/command_file.rb'
require_relative '../src/paamuk_command.rb'
require_relative '../src/request.rb'


describe PaamukCommand do

  before do
    @server = double("server")
    @command = described_class.new @server
  end

  it "stops the server" do
    @server.should_receive(:shutdown)
    response = double("response")
    response.should_receive(:body=)

    request = Request.new("", "stop", "")
    @command.resolve(request, response)
  end

  it "sets a new command" do
    response = double("response")
    response.should_receive(:body=)
    CommandFile.should_receive(:set_command).with("g", "http://www.google.com/q=%s")

    request = Request.new("", "setcommand", "g http://www.google.com/q=%s")
    @command.resolve(request, response)
  end


  it "lists all existing commands" do
    CommandFile.stub(:commands).and_return({ 
      "wp" => "http://en.wikipedia.org",
      "g" => "http://www.google.com"
    })
    response = double("response")
    response.should_receive(:body=).with(
      "Known commands:\ng\t\thttp://www.google.com\nwp\t\thttp://en.wikipedia.org"
    )

    request = Request.new("", "list", "")
    @command.resolve(request, response)
  end

end
