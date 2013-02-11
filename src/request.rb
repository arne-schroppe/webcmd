

class Request

  def self.from_string query_string
    command = ""
    arguments = ""
    namespace = "user"

    query = query_string.strip
    namespace_part = /^\w+:/.match(query)

    remaining_query = query
    if not namespace_part.nil?
      namespace_separator_index = namespace_part.end(0) - 1
      namespace = query[0 .. namespace_separator_index-1]
      remaining_query = query[namespace_separator_index+1 .. -1].strip
    end

    command_part = /^\w+ /.match(remaining_query)
    if command_part.nil?
      command = remaining_query
    else
      first_space_index = command_part.end(0) - 1
      command = remaining_query[0 .. first_space_index-1]
      arguments = remaining_query[first_space_index+1 .. -1].strip
    end

    self.new(namespace, command, arguments)
  end

  def initialize (namespace, command, arguments)
    @namespace = namespace
    @command = command
    @arguments = arguments
  end

  def command
    @command
  end

  def arguments
    @arguments
  end

  def namespace
    @namespace
  end

end
