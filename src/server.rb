#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'webrick'
require 'json'
require 'commands'
require 'request'

commands = Commands.new
expanded_path = File.expand_path("~/.paamuk.json")

server = WEBrick::HTTPServer.new :BindAddress => "127.0.0.1",
  :Port => 8000,
  :DocumentRoot => "."


trap('INT') { server.shutdown }

server.mount_proc '/' do |req, res|
  query_hash = req.query()
  query = query_hash['q']
  if not query.nil?
    command_file_content = IO.read(expanded_path)
    stored_commands = JSON.parse(command_file_content)
    commands.commands = stored_commands

    request = Request.new query.gsub("+", " ")
    url = commands.resolve_command(request.command, request.arguments)
    res.set_redirect(WEBrick::HTTPStatus::MovedPermanently, url)
  end
end

server.start
