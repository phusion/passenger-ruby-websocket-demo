# Minimal WebSocket example with Phusion Passenger

This repository demonstrates a small WebSocket-capable Rack application on Phusion Passenger 4. The application performs a WebSocket handshake and sends 10 "hello world" messages to the client with a 1 second delay between each message. Anything that the client sends is echoed back to the client, after an at most 1 second delay.

## Setup

You need:

 * Phusion Passenger >= 4.0.19.
 * Nginx >= 1.4.1 (except when using Phusion Passenger Standalone, which already takes care of Nginx).
 * The [websocket gem](https://github.com/imanel/websocket-ruby): `gem install websocket`. This is used for parsing the WebSocket protocol.
 * [wssh](https://github.com/progrium/wssh), the command line WebSocket client (requires libevent).
   * Unfortunately WSSH has been broken because of a new ws4py release. You need to manually unbreak it by following [these instructions](https://github.com/progrium/wssh/issues/17#issuecomment-15828660).
   * If you installed libevent with MacPorts then gevent may have trouble finding event.h. Use this command tell gevent where it can find libevent: `sudo env C_INCLUDE_PATH=/opt/local/include LIBRARY_PATH=/opt/local/lib python setup.py install`

Run on Phusion Passenger for Nginx:

    # Make sure this is the FIRST server entry in your Nginx config file
    # because we're going to access it through the host name '127.0.0.1'.
    # Unfortunately wssh does not support host names that are aliased to
    # 127.0.0.1 through /etc/hosts.
    server {
        listen 80;
        server_name websocket.test;
        root /path/to/minimal-passenger-websocket-example/public;
        passenger_enabled on;
    }

Run on Phusion Passenger Standalone:

    passenger start

Perform a request and see it in action:

    wssh

(`wssh` may be in /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin if you're using Python 2.7 from MacPorts)

## Protocol support

Only RFC 6455 is supported.
