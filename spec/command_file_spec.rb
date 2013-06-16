require_relative '../src/command_file'
require 'json'


describe CommandFile do

  before :all do
      @file_name = "testfile"
  end

  context "when the command file doesn't exist" do

    before (:each) do
      File.stub(:exist?).with(@file_name).and_return(false)
    end

    it "doesn't fail" do

      IO.stub(:read).and_raise(IOError.new)

      CommandFile.file_name = @file_name
      CommandFile.commands.should eq Hash.new

    end

  end


  context "when the command file exists" do

    before (:each) do
      File.stub(:exist?).with(@file_name).and_return(true)
    end


    it "reads configuration from a given file" do

      file_content = '{"a": "http://www.testpage.com/q=%s"}'
      parsed_commands = {"a" => "success"}
      IO.stub(:read).with(@file_name).and_return(file_content)
      JSON.stub(:parse).with(file_content).and_return(parsed_commands)

      CommandFile.file_name = @file_name
      CommandFile.commands.should eq parsed_commands

    end


    it "adds a command to a configuration file" do

      file_content = '{"a": "first_command"}'
      IO.stub(:read).with(@file_name).and_return(file_content)
      JSON.stub(:parse).with(file_content).and_return({"a" => "first_command"})

      result_file_content = '{"a": "first_command", "b": "second_command"}'
      JSON.stub(:pretty_generate).with({"a" => "first_command", "b" => "second_command"}).and_return(
        result_file_content)

      IO.should_receive(:write).with(@file_name, result_file_content, {"mode" => "w+"})

      CommandFile.file_name = @file_name
      CommandFile.set_command("b", "second_command")
    end

  end

end
