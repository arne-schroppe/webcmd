require 'src/paamuk_command.rb'
require 'src/request.rb'


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

end
