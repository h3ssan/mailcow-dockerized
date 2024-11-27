#!/bin/sh

until ping ${REDISHOST} -c1 > /dev/null; do
  echo "Waiting for Redis..."
  sleep 1
done
until ping ${PHPFPMHOST} -c1 > /dev/null; do
  echo "Waiting for PHP..."
  sleep 1
done
if printf "%s\n" "${SKIP_SOGO}" | grep -E '^([yY][eE][sS]|[yY])+$' >/dev/null; then
  until ping ${SOGOHOST} -c1 > /dev/null; do
    echo "Waiting for SOGo..."
    sleep 1
  done
fi
if printf "%s\n" "${SKIP_RSPAMD}" | grep -E '^([yY][eE][sS]|[yY])+$' >/dev/null; then
  until ping ${RSPAMDHOST} -c1 > /dev/null; do
    echo "Waiting for Rspamd..."
    sleep 1
  done
fi

python3 /bootstrap.py

exec "$@"