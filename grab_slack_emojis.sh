#!/usr/bin/env bash

auth_cookie_value=replace_this_with_value
token_value=replace_this_with_value
org_name=name-of-your-org

echo "fetching emoji data"

emoji_data=$(curl -s "https://$org_name.slack.com/api/emoji.adminList" \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H 'content-type: multipart/form-data' \
  -H "cookie: d=$auth_cookie_value" \
  -F token=$token_value \
  -F page=1 \
  -F count=10 \
  -F sort_by=name \
  -F sort_dir=asc | \
  jq -r .emoji)

  echo "found $(echo $emoji_data | jq 'length') emojis"
