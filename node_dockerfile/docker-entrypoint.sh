#!/bin/sh
set -e

# Tạo lại các thư mục con sau khi volume được mount
# (volume mount ghi đè build-time mkdir)
mkdir -p /app/data

exec "$@"
