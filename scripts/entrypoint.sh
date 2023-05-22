#!/bin/sh
echo Starting usbmuxd. Waiting to start Jit-Streamer.
usbmuxd -f &
sleep 5
/JitStreamer/jit_streamer