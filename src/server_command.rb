

class ServerCommand

  @@known_commands = []

  def initialize(server)
    @server = server
  end

  def resolve(request, response)
    command_name = request.command.to_sym
    if @@known_commands.include?(command_name)
      self.send(command_name, request, response)
    else
      raise "Unknown command: #{request.command}"
    end
  end

  def self.define_command(name, &block)
    @@known_commands.push(name)
    define_method(name, &block)
  end

  define_command :stop do |request, response|
    response.body = "goodbye"
    @server.shutdown
  end

  define_command :set do |request, response|
    added_command = Request.from_string request.arguments
    new_command = added_command.command
    new_command_url = added_command.arguments
    CommandFile.set_command(new_command, new_command_url)
    response.body = "Setting '#{new_command}' to '#{new_command_url}'"
  end

  define_command :list do |request, response|
    commands = []
    CommandFile.commands.each do |key, value|
      commands.push("\n#{key}\t\t#{value}")
    end
    response.body = "Known commands:" + commands.sort().join("")
  end


  define_command :help do |request, response|
    response.body = "Server commands:\n" + @@known_commands.map(&:to_s).join("\n")
  end

end
