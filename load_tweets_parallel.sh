#!/bin/sh

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time parallel ./load_denormalized.sh ::: data/*.zip

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time parallel python3 -u load_tweets.py \
    --db="postgresql://postgres:pass@localhost:15433/postgres" \
    --inputs ::: data/*.zip

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time parallel python3 -u load_tweets_batch.py \
    --db="postgresql://postgres:pass@localhost:15434/postgres" \
    --inputs ::: data/*.zip
