#!/bin/sh
set -eu

SLEEP=${SLEEP:-}
PDF_FILE=${PDF_FILE:-}
URL=${URL:-}

echo "Start chromium in background"
pm2 start chromium-browser \
    --interpreter none \
    -- \
    --no-sandbox \
    --headless \
    --hide-scrollbars \
    --remote-debugging-port=9222 \
    --disable-features=TranslateUI \
    --disable-extensions \
    --disable-component-extensions-with-background-pages \
    --disable-background-networking \
    --disable-sync \
    --metrics-recording-only \
    --disable-default-apps \
    --mute-audio \
    --no-default-browser-check \
    --no-first-run \
    --disable-backgrounding-occluded-windows \
    --disable-renderer-backgrounding \
    --disable-background-timer-throttling \
    --force-fieldtrials=*BackgroundTracing/default/

echo "Waiting for chromium to be up"
while ! nc -vz 127.0.0.1 9222; do
    echo "Retrying in 1 seconds"
    sleep 1;
done

if [ -n "$SLEEP" ]; then
    echo "Sleeping forever"
    sleep infinity
else
    if [ $# -gt 0 ] && [ "${1#-}" != "$1" ]; then
        set -- node "$@"
    fi
    exec "$@"
fi
