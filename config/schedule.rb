# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 3.minutes do
	job_type :steam_job, "cd :path && STEAM_WEB_API_KEY=:steam_web_api_key bin/rails runner -e :environment ':task' :output"
	steam_job "SteamInfo::UserInfo::cache_all; SteamInfo::SessionInfo::refresh_all_sessions"
end
