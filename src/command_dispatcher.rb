

class CommandDispatcher

  def initialize
    @commands = Hash.new
  end

  def bind_command(namespace, command)
    @commands[namespace] = command
  end


  def dispatch(request, response)
    command = @commands[request.namespace]
    command.resolve(request, response)
  end


end
