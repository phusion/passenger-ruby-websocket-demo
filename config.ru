# https://github.com/imanel/websocket-ruby
# Install with: gem install websocket
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

app = proc do |env|
  # Hijack the socket, then operate on the socket directly to send
  # websocket messages.
  env['rack.hijack'].call
  io = env['rack.hijack_io']
  begin
    # Parse client handshake message and send server handshake response.
    server = server_handshake(env)
    io.write(server.to_s)

    # Stream body data.
    10.times do |i|
      data = "Hello world #{i}"
      frame = WebSocket::Frame::Outgoing::Server.new(
        :version => server.version,
        :data => data,
        :type => :text)
      io.write(frame.to_s)
      sleep 1
    end
  ensure
    io.close
  end
end

run app
