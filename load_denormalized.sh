#!/bin/sh

file="$1"

if [ -z "$file" ]; then
    echo "Usage: sh load_denormalized.sh <data_file>"
    exit 1
fi

echo "Loading $file into denormalized database"

unzip -p "$file" \
    | sed 's/\\u0000//g' \
    | psql "postgresql://postgres:pass@localhost:15432/postgres" \
    -c "COPY tweets_jsonb(data) FROM STDIN WITH (FORMAT CSV, DELIMITER E'\x01', QUOTE E'\x02', ESCAPE E'\x02');"
