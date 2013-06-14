require 'cgi'
require 'webrick'
require_relative 'command_file'

class UserCommand


def resolve(request, response)
  encoded_line = CGI::escape(request.arguments)
  encoded_line = encoded_line.gsub("%20", "+")
  commands = CommandFile.commands
  command = commands[request.command]
  if command.nil?
    response.body = "Unknown command: '#{request.command}'. Try 'server:list' or 'server:help'."
    return
  end
  url = command.sub("%s", encoded_line)

  response.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, url)
end

end
