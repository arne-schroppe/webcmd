#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'webrick'
require 'user_command'
require 'paamuk_command'
require 'command_dispatcher'

require 'command_file'
require 'request'
require 'trollop'



options = Trollop::options do
  opt :daemon, "Run as a daemon"
  opt :port, "The port to listen on", :default => 8000
end



server = WEBrick::HTTPServer.new :BindAddress => "127.0.0.1",
  :Port => options[:port],
  :DocumentRoot => "."


command_dispatcher = CommandDispatcher.new
expanded_path = File.expand_path("~/.paamuk.json")
command_dispatcher.bind_command("user", UserCommand.new(CommandFile.new expanded_path))
command_dispatcher.bind_command("paamuk", PaamukCommand.new(server))

server.mount_proc '/' do |req, res|
  query_hash = req.query()
  query = query_hash['q']

  request = Request.from_string query.gsub("+", " ")
  command_dispatcher.dispatch(request, res)
end


trap('INT') { server.shutdown }

if options[:daemon]
  WEBrick::Daemon.start()
end

server.start
