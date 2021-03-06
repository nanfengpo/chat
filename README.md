# nanfengpo Instant Messaging Server

<img src="docs/logo.svg" align="left" width=128 height=128> Instant messaging server. Backend in pure [Go](http://golang.org) (license [GPL 3.0](http://www.gnu.org/licenses/gpl-3.0.en.html)), custom client-side binding in Java and Javascript, as well as [gRPC](https://grpc.io/) client support for C++, C#, Go, Java, Node, PHP, Python, Ruby, Objective-C (license [Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0)). Wire transport is JSON over websocket (long polling is also available) for custom bindings, or [protobuf](https://developers.google.com/protocol-buffers/) over plain TCP for gRPC. Persistent storage [RethinkDB](http://rethinkdb.com/) and MySQL. A third-party [DynamoDB adapter](https://github.com/riandyrn/chat/tree/master/server/db/dynamodb) also exists. Other databases can be supported by writing custom adapters.

nanfengpo is meant as a replacement for XMPP. On the surface it's a lot like open source WhatsApp or Telegram.

Version 0.15. This is beta-quality software: feature-complete but probably with a few bugs. Follow [instructions](INSTALL.md) to install and run. Read [API documentation](docs/API.md).


## Why?

The promise of [XMPP](http://xmpp.org/) was to deliver federated instant messaging: anyone would be able to spin up an IM server capable of exchanging messages with any other XMPP server in the world. Unfortunately XMPP never delivered on this promse. Instant messengers are still a bunch of incompatible walled gardens, similar to what AoL of the late 1990s was to the open Internet. 

The goal of this project is to actually deliver on XMPP's original vision: create a modern open platform for federated instant messaging with emphasis on mobile communication. A secondary goal is to create a decentralized IM platform which is much harder to track and block by the governments.


## Getting support

* For support, general questions, discussions post to [https://groups.google.com/d/forum/nanfengpo](https://groups.google.com/d/forum/nanfengpo).
* For bugs and feature requests [open an issue](https://github.com/nanfengpo/chat/issues/new).
* Read [API documentation](docs/API.md).


## Demo

### Web 

A web demo is usually available at https://api.nanfengpo.co/ ([source](https://github.com/nanfengpo/example-react-js/)). Login as one of `alice`, `bob`, `carol`, `dave`, `frank`. Password is `<login>123`, e.g. login for `alice` is `alice123`. You can discover other users by email or phone by prefixing them with `email:` or `tel:` respectively. Emails are `<login>@example.com`, e.g. `alice@example.com`, phones are `17025550001` through `17025550009`.

### Android

[Android demo](https://github.com/nanfengpo/android-example) is mostly stable and functional. See screenshots below. A [debug APK](https://github.com/nanfengpo/android-example/releases/latest) is provided for convenience.

### Command Line

A text-only [command line client](./tn-cli) implements every possible command.

### Notes

* The demo server is reset (all data wiped) every night at 3:15 am Pacific time. An error message `User not found or offline` means the server was reset while you were connected. If you see it on the web, reload and relogin; on Android delete the app then reinstall.

* User `Tino` is a [basic chatbot](./chatbot) which responds with a [random quote](http://fortunes.cat-v.org/) to any message.

* As generally accepted, when you register a new account you are asked for an email address. The server will send an email with a verification code to that address and you can use it to validate the account. To make things easier for testing, the server will also accept `123456` as a verification code. Remove line `"debug_response": "123456"` from `nanfengpo.conf` to disable this option.

* The demo server is configured to use [ACME](https://letsencrypt.org/) TLS [implementation](https://godoc.org/golang.org/x/crypto/acme) with hard-coded requirement for [SNI](https://en.wikipedia.org/wiki/Server_Name_Indication). If you are unable to connect then the most likely reason is your TLS client's missing support for SNI. Use a different client. 

## Features

### Supported

* [Android](https://github.com/nanfengpo/android-example/), [web](https://github.com/nanfengpo/example-react-js/), and [command line](tn-cli/) clients.
* One-on-one messaging.
* Group messaging with every member's access permissions managed individually. The maximum number of members is configurable (128 by default).
* Topic access control with permissions for various actions.
* Server-generated presence notifications for people, topics.
* Support for custom authentication backends.
* Sharded clustering with failover.
* Persistent message store, paginated message history.
* Javascript bindings with no external dependencies.
* Java bindings (dependencies: [Jackson](https://github.com/FasterXML/jackson), [Java-Websocket](https://github.com/TooTallNate/Java-WebSocket)). Suitable for Android but with no Android SDK dependencies.
* Websocket, long polling, and [gRPC](https://grpc.io/) over TCP transports.
* JSON or [protobuf version 3](https://developers.google.com/protocol-buffers/) wire protocols.
* [TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) with [Letsenrypt](https://letsencrypt.org/) or conventional certificates.
* User search/discovery.
* Rich formatting of messages, markdown-style: \*style\* &rarr; **style**.
* Inline images and file attachments.
* Message status notifications: message delivery to server; received and read notifications; typing notifications.
* Support for client-side caching.
* Ability to block unwanted communication server-side.
* Anonymous users (important for use cases related to tech support over chat).
* Mobile push notifications using [FCM](https://firebase.google.com/docs/cloud-messaging/).
* Support for storage and out of band transfer of large objects like video files.
* Plugins to extend functionality like enabling chat bots.

### Planned

* iOS client bindings and client.
* Federation.
* End to end encryption with [OTR](https://en.wikipedia.org/wiki/Off-the-Record_Messaging) for one-on-one messaging and undecided method for group messaging.
* Group messaging with unlimited number (or hundreds of thousands) of members with bearer token access control.
* Hot standby.
* Different levels of message persistence (from strict persistence to "store until delivered" to purely ephemeral messaging).

## Screenshots

### Android

<p align="center">
<img src="docs/android-chats.png" alt="android screenshot" width=270 /> <img src="docs/android-messages.png" alt="android screenshot" width=270 />
</p>

### Desktop Web

<p align="center">
  <img src="docs/web-desktop-2.png" alt="Desktop web: full app" width=866 />
</p>

### Mobile Web

<p align="center">
  <kbd><img src="docs/web-mob-contacts-1.png" alt="Mobile web: contacts" width=323 /></kbd> <kbd><img src="docs/web-mob-chat-1.png" alt="Mobile web: chat" width=323 /></kbd> <kbd><img src="docs/web-mob-info-1.png" alt="Mobile web: topic info" width=323 /></kbd> <kbd><img src="docs/web-mob-new-chat-1.png" alt="Mobile web: start new 1:1 chat" width=323 /></kbd>
</p>


#### SEO Strings (word 'chat' in Chinese, Russian, and Persian)

聊天室 чат گپ