require 'json'

class CommandFile


  def initialize file_name
    @file_name = file_name
  end

  def commands
    command_file_content = IO.read(@file_name)
    stored_commands = JSON.parse(command_file_content)
    stored_commands
  end


end
