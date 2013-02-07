require 'cgi'
require 'webrick'

class UserCommand

def initialize command_source
  @command_source = command_source
end


def resolve(request, response)
  encoded_line = CGI::escape(request.arguments)
  encoded_line = encoded_line.gsub("%20", "+")
  commands = @command_source.commands
  url = commands[request.command].sub("%s", encoded_line)

  response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, url)
end

end
