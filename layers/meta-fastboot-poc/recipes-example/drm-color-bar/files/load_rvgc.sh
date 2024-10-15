#!/bin/bash
modprobe rcar-cr52-remoteproc
sleep 0.1s
modprobe virtio-rpmsg-bus
sleep 0.1s
modprobe rcar-rvgc-drm
sleep 0.1s
