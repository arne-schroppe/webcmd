require 'json'

module CommandFile


  def self.file_name= file_name
    @file_name = file_name
  end

  def self.commands
    stored_commands = Hash.new
    if File.exist? @file_name then
      command_file_content = IO.read(@file_name)
      stored_commands = JSON.parse(command_file_content)
    end
    stored_commands
  end

  def self.set_command(command, url)
    commands = self.commands
    commands[command] = url

    command_file_content = JSON.pretty_generate(commands)
    IO.write(@file_name, command_file_content, {"mode" => "w+"})
  end


end
