#!/usr/bin/env bash

auth_cookie_value=
token_value=
org_name=

source credentials.sh

target_folder_name="emojis"

echo "fetching emoji data"

emoji_data=$(curl -s "https://$org_name.slack.com/api/emoji.adminList" \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H 'content-type: multipart/form-data' \
  -H "cookie: d=$auth_cookie_value" \
  -F token="$token_value" \
  -F page=1 \
  -F count=5000 \
  -F sort_by=name \
  -F sort_dir=asc | \
  jq -r .emoji)

echo "found $(echo "$emoji_data" | jq 'length') emojis"

echo "$emoji_data" | jq -c '.[]' | while read -r entry; do
  name=$(echo "$entry" | jq -r .name)
  url=$(echo "$entry" | jq -r .url)

  echo "$name - $url";
  destination_folder="$target_folder_name/$name"
  curl --create-dirs -O --output-dir "$destination_folder" "$url"
done
