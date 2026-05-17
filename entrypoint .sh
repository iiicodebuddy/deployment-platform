#!/bin/bash
set -e

echo "Starting PHP-FPM..."
php-fpm -F &
PHP_PID=$!

echo "Waiting for PHP-FPM to start..."
sleep 2


#enhanced version with better logging and graceful shutdown handling
# set -e

# log() {
#   echo "[$(date +"%Y-%m-%d %H:%M:%S")] $*"
# }

# shutdown() {
#   log "Shutdown requested. Stopping PHP-FPM..."
#   kill -TERM "$PHP_PID" 2>/dev/null || true
#   wait "$PHP_PID" 2>/dev/null || true
# }
# trap shutdown SIGINT SIGTERM

# log "Starting PHP-FPM..."
# php-fpm -F &
# PHP_PID=$!

# log "Waiting for PHP-FPM to become ready..."
# for i in $(seq 1 10); do
#   if kill -0 "$PHP_PID" 2>/dev/null; then
#     log "PHP-FPM is running (PID $PHP_PID)."
#     break
#   fi
#   log "Waiting for PHP-FPM ($i/10)..."
#   sleep 1
# done

# if ! kill -0 "$PHP_PID" 2>/dev/null; then
#   log "ERROR: PHP-FPM failed to start. Exiting."
#   exit 1
# fi

# log "Starting Nginx..."
# exec nginx -g "daemon off;"

echo "Starting Nginx..."
nginx -g "daemon off;"

wait $PHP_PID