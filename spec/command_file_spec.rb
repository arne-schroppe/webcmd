require 'src/command_file'
require 'json'



describe CommandFile do

  it "reads configuration from a given file" do

    file_name = "testfile"
    file_content = '{"a": "http://www.testpage.com/q=%s"}'
    parsed_commands = {"a" => "success"}
    IO.stub(:read).with(file_name).and_return(file_content)
    JSON.stub(:parse).with(file_content).and_return(parsed_commands)

    command_file = CommandFile.new file_name

    command_file.commands.should eq parsed_commands

  end

end
