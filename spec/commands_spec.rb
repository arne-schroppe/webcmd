require 'src/commands'
require 'rubygems'
require 'rspec'


describe Commands do

  before do
    @commands = described_class.new
  end


  it "resolves a command to a url" do
    @commands.commands = { "g" => "http://www.google.com" }
    @commands.resolve_command("g", "").should eq "http://www.google.com"
  end


  it "substitutes parameters in the url" do
    @commands.commands = { "c2" => "http://c2.com/cgi/wiki?search=%s" }
    @commands.resolve_command("c2", "AlanKaysReadingList").should eq "http://c2.com/cgi/wiki?search=AlanKaysReadingList"
  end


  it "replaces spaces with + signs in command arguments" do
    @commands.commands = { "wp" => "http://en.wikipedia.com/?search=%s" }
    @commands.resolve_command("wp", "Centroidal Voronoi tessellation").should eq "http://en.wikipedia.com/?search=Centroidal+Voronoi+tessellation"
  end

  it "encodes illegal characters" do
    @commands.commands = { "am" => "http://www.amazon.com/s/?field-keywords=%s" }
    @commands.resolve_command("am", '"smalltalk" ?/#^:').should eq "http://www.amazon.com/s/?field-keywords=%22smalltalk%22+%3F%2F%23%5E%3A"
  end

end
