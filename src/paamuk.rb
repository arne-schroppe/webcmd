#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'webrick'
require 'user_command'
require 'command_file'
require 'request'
require 'trollop'



options = Trollop::options do
  opt :daemon, "Run as a daemon"
  opt :port, "The port to listen on", :default => 8000
end

expanded_path = File.expand_path("~/.paamuk.json")
user_command = UserCommand.new(CommandFile.new expanded_path)

server = WEBrick::HTTPServer.new :BindAddress => "127.0.0.1",
  :Port => options[:port],
  :DocumentRoot => "."


server.mount_proc '/' do |req, res|
  query_hash = req.query()
  query = query_hash['q']

  if query == "paamuk:stop"
    res.body = "goodbye"
    server.shutdown
  elsif not query.nil?
    request = Request.from_string query.gsub("+", " ")
    user_command.resolve(request, res)
  end
end


trap('INT') { server.shutdown }

if options[:daemon]
  WEBrick::Daemon.start()
end

server.start
