#!/usr/bin/ruby


require 'webrick'
require 'Commands'
require 'Request'

commands = Commands.new
commands.add_command("g", "http://www.google.com/search?q=%s")
commands.add_command("wp", "http://en.wikipedia.org/?search=%s")
commands.add_command("wpde", "http://de.wikipedia.org/?search=%s")
commands.add_command("c2", "http://c2.com/cgi/wiki?search=%s")


server = WEBrick::HTTPServer.new :BindAddress => "127.0.0.1",
  :Port => 8000,
  :DocumentRoot => "."


trap('INT') { server.shutdown }

server.mount_proc '/' do |req, res|
  query_hash = req.query()
  query = query_hash['q']
  if not query.nil?
    request = Request.new query.sub("+", " ")
    url = commands.resolve_command(request.command, request.arguments)
    res.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, url)
  end
end

server.start
