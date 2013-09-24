# Minimal WebSocket example with Phusion Passenger

This repository demonstrates a small WebSocket-capable Rack application on Phusion Passenger 4. The application performs a WebSocket handshake and sends 10 "hello world" messages to the client with a 1 second delay between each message. Anything that the client sends is echoed back to the client, after an at most 1 second delay.

## Getting started

Install the gem bundle and start Phusion Passenger Standalone.

    bundle install
    bundle exec passenger start

You also need to install [wssh](https://github.com/progrium/wssh), the WebSocket command line client:

    git clone https://github.com/progrium/wssh.git ~/wssh
    cd ~/wssh
    sudo python setup.py install

Note that wssh requires libevent (because wssh uses gevent). If you installed libevent with MacPorts then gevent may have trouble finding event.h. Use this command tell gevent where it can find libevent: `sudo env C_INCLUDE_PATH=/opt/local/include LIBRARY_PATH=/opt/local/lib python setup.py install`

## Compatibility

 * This app uses plain Rack, and thus is framework agnostic.
 * WebSockets works on Phusion Passenger for Apache, Phusion Passenger for Nginx and Phusion Passenger Standalone.
 * At least version 4.0.5 of Phusion Passenger is required.
 * Only the RFC 6455 version of the WebSocket protocol is supported.

## Testing

Perform a request and see it in action:

    wssh localhost:3000/

(`wssh` may be in /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin if you're using Python 2.7 from MacPorts)

While wssh is active, whenever you type anything into the console and press Enter, the server will echo it back to you.

## Multithreading and performance

WebSockets works great on both the open source variant of Phusion Passenger, as well as on [Phusion Passenger Enterprise](https://www.phusionpassenger.com/). For optimal performance, Phusion Passenger Enterprise with multithreading is recommended. You should use the following settings for enabling multithreading. The more concurrent users you have, the higher your thread count should be. As a rule, your thread count should be at least the number of WebSocket sessions you have.

Apache:

    PassengerConcurrencyModel thread
    PassengerThreadCount 64

Nginx:

    passenger_concurrency_model thread
    passenger_thread_count 64

## Feedback

Please join [the discussion forum](http://groups.google.com/group/phusion-passenger) if you have questions or feedback about this demo.
