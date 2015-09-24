# WebSockets on Phusion Passenger

This application demonstrates WebSocket support in [Phusion Passenger](https://www.phusionpassenger.com/). Passenger supports all major modern web technologies, such as WebSockets, entirely out of the box. You don't have to do anything: WebSocket support just works.

If you like this demo, please [tweet about it](https://twitter.com/share) or [follow us on Twitter](https://twitter.com/phusion_nl).

More information about Passenger:

 * [Website](https://www.phusionpassenger.com/)
 * [Documentation](https://www.phusionpassenger.com/library/)
 * [Support](https://www.phusionpassenger.com/support)
 * [Source code](https://github.com/phusion/passenger)
 * [Community discussion forum](https://groups.google.com/d/forum/phusion-passenger)
 * [Issue tracker](https://github.com/phusion/passenger/issues)

## Getting started

Clone this repository, install the gem bundle and start Passenger Standalone.

    git clone https://github.com/phusion/passenger-ruby-websocket-demo.git
    cd passenger-ruby-websocket-demo
    bundle install
    bundle exec passenger start

Access the demo application at http://0.0.0.0:3000/ and see it in action.

If you deploy this demo to production, be sure to enable [sticky sessions](https://www.phusionpassenger.com/library/config/nginx/reference/#passenger_sticky_sessions) in Passenger.

## Compatibility

 * This app uses plain Rack, and thus is framework agnostic.
 * WebSockets work on Passenger for Nginx and Passenger Standalone. [Apache is currently not supported](https://github.com/phusion/passenger/issues/1202).
 * At least version 4.0.5 of Passenger is required.
 * Only the RFC 6455 version of the WebSocket protocol is supported.

## Multithreading and performance

WebSockets work great on both the open source variant of Phusion Passenger, as well as on [Phusion Passenger Enterprise](https://www.phusionpassenger.com/enterprise). For optimal performance, Phusion Passenger Enterprise with multithreading is recommended. You should use the following settings for enabling multithreading. The more concurrent users you have, the higher your thread count should be. As a rule, your thread count should be at least the number of WebSocket sessions you have.

Nginx:

    passenger_concurrency_model thread
    passenger_thread_count 64

Standalone:

    {
      "concurrency_model": "thread",
      "thread_count": 64
    }

## Next steps

 * Using WebSockets on Phusion Passenger? [Tweet about us](https://twitter.com/share), [follow us on Twitter](https://twitter.com/phusion_nl) or [fork us on Github](https://github.com/phusion/passenger).
 * Having problems? Please post a message at [the community discussion forum](https://groups.google.com/d/forum/phusion-passenger).

[<img src="http://www.phusion.nl/assets/logo.png">](http://www.phusion.nl/)

Please enjoy Phusion Passenger, a product by [Phusion](http://www.phusion.nl/). :-)
