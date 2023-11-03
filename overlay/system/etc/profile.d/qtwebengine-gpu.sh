#!/bin/sh
# This file is part of lxc-android-config

# Set some baseline performance optimizations
GPU_FEATURES="--enable-gpu-rasterization"

# No default multimedia capabilities by default
MEDIA_FEATURES=""

if [ -f /system/build.prop ]; then
    # Conditionally disable GPU compositing for QtWebEngine on unsupported devices
    DISABLE_GPU_PROP=$(device-info get QtWebEngineNoGpuCompositing)
    if [ "$DISABLE_GPU_PROP" = "true" ]; then
        GPU_FEATURES="${GPU_FEATURES} --disable-gpu-compositing"
    fi

    # Conditionally enable OMX video decoding capabilities using Mojo
    DISABLE_ACCEL_VIDEO_DECODE_PROP=$(device-info get QtWebEngineNoAccelVideoDecoding)
    if [ "$DISABLE_ACCEL_VIDEO_DECODE_PROP" != "true" ]; then
        MEDIA_FEATURES="--enable-accelerated-video-decode --enable-features=MojoVideoDecoder"
    fi
fi

export QTWEBENGINE_CHROMIUM_FLAGS="$GPU_FEATURES $MEDIA_FEATURES --widevine-path=/home/phablet/.cache/morph-browser/libwidevinecdm.so"
