module SteamInfo
	module AppInfo
		def self.init_db
			SteamApp.delete_all
			apps = JSON.parse(open('http://api.steampowered.com/ISteamApps/GetAppList/v2').read)['applist']['apps']
			ActiveRecord::Base.transaction do
				apps.each do |app|
					SteamApp.create(id: app['appid'], name: app['name'])
				end
			end
		end
	end

	module UserInfo
		def self.get(uids, *param_list)
			user_infos = JSON.parse(open("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=#{Devise.omniauth_configs[:steam].strategy.api_key}&steamids=#{uids}").read)

			to_return = {}
			user_infos["response"]["players"].each do |user_info|
				uid = user_info["steamid"]
				to_return[uid] = {}

				param_list.each do |param|
					to_return[uid][param] = UserInfo.method(param).call user_info
				end
			end

			to_return
		end

		def self.in_game(user_info)
			!user_info['gameextrainfo'].nil?
		end

		def self.simple_status_str(user_info)
			"in-game" if user_info['gameid']
			if user_info['personastate'] > 0
				"online"
			else
				"offline"
			end
		end

		def self.playing(user_info)
			{id: user_info['gameid'], name: user_info['gameextrainfo']}
		end

		def self.image(user_info)
			user_info['avatarmedium']
		end

		def self.profile_url(user_info)
			user_info['profileurl']
		end

		def self.username(user_info)
			user_info['personaname']
		end
	end
end
