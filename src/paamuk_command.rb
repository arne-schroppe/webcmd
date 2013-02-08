

class PaamukCommand

  def initialize(server)
    @server = server
  end

  def resolve(request, response)
    if request.command == "stop"
      self.stop response
    end
  end

  def stop response
    response.body = "goodbye"
    @server.shutdown
  end


end
