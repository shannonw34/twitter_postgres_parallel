#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time echo "$files" | tr ' ' '\n' | parallel ./load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time printf '%s\n' "$files" | parallel python3 -u load_tweets.py \
    --db="postgresql://postgres:pass@localhost:15433/postgres" \
    --inputs

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time printf '%s\n' "$files" | parallel python3 -u load_tweets_batch.py \
    --db="postgresql://postgres:pass@localhost:15434/postgres" \
    --inputs
