require 'cgi'
require 'webrick'
require_relative 'command_file'

class UserCommand


def resolve(request, response)
  encoded_line = CGI::escape(request.arguments)
  encoded_line = encoded_line.gsub("%20", "+")
  commands = CommandFile.commands
  url = commands[request.command].sub("%s", encoded_line)

  response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, url)
end

end
