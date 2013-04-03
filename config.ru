require 'websocket'

def server_handshake(env)
  data = "#{env['REQUEST_METHOD']} #{env['REQUEST_URI']} #{env['SERVER_PROTOCOL']}\r\n"
  env.each_pair do |key, val|
    if key =~ /^HTTP_(.*)/
      name = rack_env_key_to_http_header_name($1)
      data << "#{name}: #{val}\r\n"
    end
  end
  data << "\r\n"

  server = WebSocket::Handshake::Server.new
  server << data
  puts "WebSocket request:"
  puts data
  puts
  puts "WebSocket response:"
  puts server
  return server
end

def rack_env_key_to_http_header_name(key)
  name = key.downcase.gsub('_', '-')
  name[0] = name[0].upcase
  name.gsub!(/-(.)/) do |chr|
    chr.upcase
  end
  name
end

def process_input(io, server, input_parser)
  # Slurp as much input as possible.
  begin
    while select([io], nil, nil, 0)
      input_parser << io.readpartial(1024)
    end
  rescue EOFError
  end

  # Parse all input into WebSocket frames and process them.
  while (frame = input_parser.next)
    send_output(io, server, "Echo: #{frame}\n")
  end
end

def send_output(io, server, data)
  frame = WebSocket::Frame::Outgoing::Server.new(
    :version => server.version,
    :data => data,
    :type => :text)
  io.write(frame.to_s)
end

app = proc do |env|
  # Hijack the socket, then operate on the socket directly to send
  # websocket messages.
  env['rack.hijack'].call
  io = env['rack.hijack_io']
  begin
    # Parse client handshake message and send server handshake response.
    server = server_handshake(env)
    io.write(server.to_s)

    # Handle input and stream responses.
    input_parser = WebSocket::Frame::Incoming::Server.new(:version => server.version)
    10.times do |i|
      process_input(io, server, input_parser)
      send_output(io, server, "Hello world #{i}\n")
      sleep 1
    end
  ensure
    io.close
  end
end

run app
