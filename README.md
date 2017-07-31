# Roomba library for NodeMCU platform

This library can be used to send control commands to a Roomba using the NodeMCU (ESP8266).

![roomba-nodemcu-esp8266](https://user-images.githubusercontent.com/153401/28676548-74c24818-72da-11e7-8d8b-59fa7309dacf.jpg)

# Status

Still in early development...

# Getting started

Edit `init.lua` with your Roomba code, then type `make all` to upload everything to your NodeMCU.

# Platform config

Tested on NodeMCU v2, with the following build parameters:

```
NodeMCU custom build by frightanic.com
branch: 1.5.4.1-final
SSL: true
modules: bit,cjson,crypto,dht,file,gpio,i2c,mqtt,net,node,pwm,rtcmem,rtctime,sntp,spi,tmr,u8g,uart,ucg,websocket,wifi,tls
```

Firmware built using [NodeMCU Build](https://nodemcu-build.com/)

# Todo

* [ ] Obtain data from sensors
* [ ] Create functions for Roomba actions, such as `spinleft()`, `driveforward()`, and `wakeup()`
* [ ] Send sensor data, and receive commands via MQTT

# Contributing

If you find any bugs or issues, please [create an issue](https://github.com/aw/roomba-nodemcu/issues/new).

If you want to improve this library, please start with the Todo list, and make a pull-request.

# License

[MIT License](LICENSE)

Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>
