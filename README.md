# sss_desertbus
[superseriousstats](https://github.com/tommyrot/superseriousstats/) config for the DesertBus community IRC chat

Stats hosted at [stats.dbcommunity.org](http://stats.dbcommunity.org)

## installation
Build the Docker image
`docker build -t chat-stats .`

Add generation script and database backup to cron (every hour and at 00:10 every day respectively)

`crontab -e`

`0 */1 * * * /path/to/sss_desertbus/genStats.sh /path/to/weechat/#channel-logfile.weechatlog`

`10 0 * * * logrotate --state /path/to/sss_desertbus/logrotate.status /path/to/sss_desertbus/logrotate.conf`

## running superseriousstats manually
Import new daily logs, and generate stats page

`genStats.sh /path/to/weechat/#channel-logfile.weechatlog`

Split single .weechatlog file into daily .weechatlogs (already included in genStats.sh)

`splitLogs.py -f /path/to/.weechatlog -p /path/to/daily/logs/newserver.desertbus. -s .weechatlog`
