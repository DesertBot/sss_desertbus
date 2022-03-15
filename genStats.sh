#!/bin/bash

conf_dir=$(dirname "$(readlink -f "$0")")
parent_dir="$(dirname "$conf_dir")"
logs_dir="$parent_dir/working_logs"
website_dir="$(dirname "$parent_dir")/www"

source_log="$1"

if [ -f "$conf_dir/stats-gen.lock" ]; then
    echo "!!! Stats generation is already in progress !!!"
    echo "### If you're sure that's not the case, delete the stats-gen.lock file"
    exit
fi

touch "$conf_dir/stats-gen.lock"

echo "### Splitting single .weechatlog into daily logs..."
python3 "$conf_dir/splitLogs.py" -f "$source_log" -p "$logs_dir/newserver.desertbus." -s .weechatlog -c

echo "### Importing daily logs and generating stats page..."
docker run -it -v "$conf_dir/nick_aliases.txt:/tmp/nick_aliases.txt" -v "$conf_dir/desertbus.db3:/tmp/db/desertbus.db3" -v "$logs_dir:/tmp/logs" -v "$website_dir:/var/www/html/sss" --rm chat-stats

rm "$conf_dir/stats-gen.lock"

echo "### Done!"
