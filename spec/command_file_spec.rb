require_relative '../src/command_file'
require 'json'



describe CommandFile do

  it "reads configuration from a given file" do

    file_name = "testfile"
    file_content = '{"a": "http://www.testpage.com/q=%s"}'
    parsed_commands = {"a" => "success"}
    IO.stub(:read).with(file_name).and_return(file_content)
    JSON.stub(:parse).with(file_content).and_return(parsed_commands)

    CommandFile.file_name = file_name
    CommandFile.commands.should eq parsed_commands

  end


  it "adds a command to a configuration file" do

    file_name = "testfile"
    file_content = '{"a": "first_command"}'
    IO.stub(:read).with(file_name).and_return(file_content)
    JSON.stub(:parse).with(file_content).and_return({"a" => "first_command"})

    result_file_content = '{"a": "first_command", "b": "second_command"}'
    JSON.stub(:pretty_generate).with({"a" => "first_command", "b" => "second_command"}).and_return(
      result_file_content)

    IO.should_receive(:write).with(file_name, result_file_content, {"mode" => "w"})

    CommandFile.file_name = file_name
    CommandFile.set_command("b", "second_command")
  end

end
