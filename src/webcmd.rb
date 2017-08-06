#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'bundler/setup'

require 'webrick'
require 'user_command'
require 'server_command'
require 'command_dispatcher'

require 'command_file'
require 'request'

require 'trollop'

#TODO
#make it possible to start without a .webcmd.json, only with setcommand
#make it possible to use the POST-method
#use backticks in arguments to run system commands (is that safe? investigate)


options = Trollop::options do
  opt :daemon, "Run as a daemon"
  opt :port, "The port to listen on", :default => 8000
end



server = WEBrick::HTTPServer.new :BindAddress => "127.0.0.1",
  :Port => options[:port],
  :DocumentRoot => "."


command_dispatcher = CommandDispatcher.new
expanded_path = File.expand_path("~/.webcmd.json")
CommandFile.file_name = expanded_path
command_dispatcher.bind_command("user", UserCommand.new)
command_dispatcher.bind_command("server", ServerCommand.new(server))

server.mount_proc '/' do |req, res|
  query_hash = req.query()
  query = query_hash['q']

  if not query.nil?
    request = Request.from_string query
    command_dispatcher.dispatch(request, res)
  end
end


trap('INT') { server.shutdown }

if options[:daemon]
  WEBrick::Daemon.start()
end

server.start
