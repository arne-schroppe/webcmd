
class Commands

def initialize
  @commands = Hash.new
end

def add_command(command, url)
  @commands[command] = url
end


def resolve_command(command, argument_line)
  encoded_line = argument_line.sub(" ", "+")
  @commands[command].sub("%s", encoded_line)
end

end
