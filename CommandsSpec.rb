require 'Commands'
require 'rubygems'
require 'rspec'


describe Commands do

  before do
    @commands = described_class.new
  end


  it "resolves a command to a url" do
    @commands.add_command("g", "http://www.google.com")
    @commands.resolve_command("g", "").should eq "http://www.google.com"
  end


  it "substitutes parameters in the url" do
    @commands.add_command("c2", "http://c2.com/cgi/wiki?search=%s")
    @commands.resolve_command("c2", "AlanKaysReadingList").should eq "http://c2.com/cgi/wiki?search=AlanKaysReadingList"
  end


  it "replaces spaces with + signs in command arguments" do
    @commands.add_command("wp", "http://en.wikipedia.com/?search=%s")
    @commands.resolve_command("wp", "Voronoi Diagram").should eq "http://en.wikipedia.com/?search=Voronoi+Diagram"
  end

end
