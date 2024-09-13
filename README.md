# Emoji transfer

For when you want to move your custom emojis from slack to some other tool

## How to download slack custom emojis

- install [jq](https://jqlang.github.io/jq/)
- set up your credentials in `credentials.sh`
  - `org_name` is the name of your organisation, you can determine it from the URL when you access your account settings in slack's web UI.
    The URL will be of the format `<org_name>.slack.com`
  - `auth_cookie_value` is the value of the `d` cookie when browsing `<org_name>.slack.com` while logged in
  - `token_value` is the authentication token value that your browser sends when fetching emoji information via the web ui
    - browse to `https://<org_name>.slack.com/customize/emoji`, inspect the source code and search for `api_token`. 
      Alternatively, inspect your browser's traffic while on that page and look for requests that send the `token` field as form data
- execute `./grab_slack_emojis.sh` from your terminal
- the script will create a folder called `emojis` and inside one folder per emoji named after the emoji name, which contains the emoji image file
- in case you have a lot of emojis, you might need to tune the `max_emojis_fetched` parameter
