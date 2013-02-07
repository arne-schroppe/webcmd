

class Request

  def self.from_string query_string
    command = ""
    arguments = ""
    namespace = "user"

    query = query_string.strip
    namespace_separator_index = query.index(":")

    remaining_query = query
    if not namespace_separator_index.nil?
      namespace = query[0 .. namespace_separator_index-1]
      remaining_query = query[namespace_separator_index+1 .. -1].strip
    end

    first_space_index = remaining_query.index(" ")
    if first_space_index.nil?
      command = remaining_query
    else
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
