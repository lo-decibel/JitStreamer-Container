# JitStreamer Container
 
 Files to build and run a containerised (Docker) version of [JitStreamer](http://jitstreamer.com) for self-hosting.

 ## Running JitStreamer

Make sure you download the JitStreamer iOS shortcut from [http://jitstreamer.com](http://jitstreamer.com]), and edit the shortcut in the Shortcuts app to point to the http(s) address and port on the host you intend to run your JitStreamer instance on. The default port is 3000, but you can specify the port in `docker-compose.yml`. Other options can be found in `config/config.toml`

To build the image, clone this repository and run

```sh
docker build -t local/jit-streamer .
```

Plug in your device via USB to the computer you are hosting JitStreamer on, and spin up the container with

```sh
docker compose up -d
```

Wait a few seconds for JitStreamer to load, then run

```sh
docker exec -it jit-streamer pair-device
```

to pair your device. Run the JitStreamer shortcut on your iOS device, and follow the prompts to pair it with your JitStreamer instance. You will need to enter the code generated by your iOS device on your Jit-Streamer host.

Once finished, exit the pairing promt on your host, unplug your device and you should be good to go.

Note: `versions.json` will need to be manually updated when you upgrade iOS. You can find the latest version on the [JitStreamer repository](https://github.com/jkcoxson/JitStreamer/blob/master/versions.json). Place the file into the same folder as `docker-compose.yml`

Have fun!