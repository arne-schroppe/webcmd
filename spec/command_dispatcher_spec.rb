
require 'src/command_dispatcher'

describe CommandDispatcher do

  before do
    @dispatcher = CommandDispatcher.new
  end

  it "executes commands bound to namespaces" do
    command = double("command")
    request = Request.new("namespace", "cmd", "args")
    @dispatcher.bind_command("namespace", command)
    response = double("response")
    command.should_receive(:resolve).with(request, response)
    @dispatcher.dispatch(request, response)
  end

end
