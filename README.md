# Minimal WebSocket example with Phusion Passenger

This repository demonstrates a small WebSocket-capable Rack application on Phusion Passenger 4. The application performs a WebSocket handshake and sends 10 "hello world" messages to the client with a 1 second delay between each message.

## Setup

You need:

 * Phusion Passenger >= 4.0.0 RC5.
 * Nginx >= 1.3.15 (except when using Phusion Passenger Standalone).
 * The [websocket gem](https://github.com/imanel/websocket-ruby): `gem install websocket`. This is used for parsing the WebSocket protocol.
 * [wssh](https://github.com/progrium/wssh), the command line WebSocket client (requires libevent).

Run on Phusion Passenger for Nginx:

    server {
        listen 80;
        server_name websocket.test;
        root /path/to/minimal-passenger-websocket-example/public;
        passenger_enabled on;
    }

Edit your `/etc/hosts` and add `127.0.0.1 websocket.test`.

Run on Phusion Passenger Standalone:

    passenger start --nginx-version=1.3.15

Perform a request and see it in action:



## Protocol support

Only RFC 6455 is supported.
