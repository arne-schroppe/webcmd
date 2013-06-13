

class PaamukCommand

  def initialize(server)
    @server = server
  end

  def resolve(request, response)
    if request.command == "stop"
      self.stop response
    elsif request.command == "setcommand" or request.command == "setc"
      self.setcommand request, response
    elsif request.command == "list"
      self.list response
    end
  end

  def stop response
    response.body = "goodbye"
    @server.shutdown
  end

  def setcommand(request, response)
    added_command = Request.from_string request.arguments
    new_command = added_command.command
    new_command_url = added_command.arguments
    CommandFile.set_command(new_command, new_command_url)
    response.body = "Setting '#{new_command}' to '#{new_command_url}'"
  end

  def list(response)
    commands = []
    CommandFile.commands.each do |key, value|
      commands.push("\n#{key}\t\t#{value}")
    end
    response.body = "Known commands:" + commands.sort().join("")
  end
end
