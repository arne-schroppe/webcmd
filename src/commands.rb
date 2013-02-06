require 'cgi'

class Commands

def initialize
  @commands = Hash.new
end

def commands= commands
  @commands = commands
end


def resolve_command(command, argument_line)
  encoded_line = CGI::escape(argument_line)
  encoded_line = encoded_line.gsub("%20", "+")
  @commands[command].sub("%s", encoded_line)
end

end
