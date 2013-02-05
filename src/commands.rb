
class Commands

def initialize
  @commands = Hash.new
end

def commands= commands
  @commands = commands
end


def resolve_command(command, argument_line)
  encoded_line = argument_line.gsub(" ", "+")
  @commands[command].sub("%s", encoded_line)
end

end
