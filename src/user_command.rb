require 'cgi'
require 'webrick'
require_relative 'command_file'

class UserCommand

DEFAULT_COMMAND = "https://www.google.com/search?q=%s".freeze

def resolve(request, response)
  encoded_line = CGI::escape(request.arguments)
  encoded_line = encoded_line.gsub("%20", "+")
  commands = CommandFile.commands
  command = commands[request.command]
  if command.nil?
    default_url = DEFAULT_COMMAND.sub("%s", request.command + "+" + encoded_line)
    response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, default_url)
    return
  end
  url = command.sub("%s", encoded_line)

  response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, url)
end

end
