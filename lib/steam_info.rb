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
		def self.remote_user_info(*uids)
			JSON.parse(open("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=#{Devise.omniauth_configs[:steam].strategy.api_key}&steamids=#{uids.join ','}").read)["response"]["players"]
		end

		def self.cache_all
			uids = User.where(provider: 'steam').select(:uid).uniq.pluck(:uid)
			cache_uids *uids
			Rails.cache.write(:steam_user_info, DateTime.now)
		end

		def self.cache_uids(*uids)
			remote_user_info(*uids).each do |user_info|
				Rails.cache.write([:steam_user_info, user_info['steamid']],
													user_info,
													expires_in: 3.minutes
												 )
			end
		end

		def self.get(uids, *param_list)
			to_return = {}
			uids.each do |uid|
				user_info = Rails.cache.fetch [:steam_user_info, uid], expires_in: 3.minutes do
					remote_user_info(uid)[0]
				end

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

	module SessionInfo
		def self.refresh_all_sessions
			steam_uids = User.where(provider: 'steam').pluck(:uid)
			session_infos = UserInfo.get(steam_uids, :playing)
			session_infos.each do |uid, game_info|
				user = User.where(uid: uid)
				unless user
					next
				end

				current_session = PlaySession.where(user: user).order(:created_at).last
				if current_session
					# If in the same session
					if current_session.steam_app_id == game_info[:id] or current_session.game_name == game_info[:name]
						next
					else
						current_session.finished_at = DateTime.now
					end
				end

				unless game_info[:id].nil? and game_info[:name].nil?
					PlaySession.create(user: user,
														 steam_app_id: game_info[:id],
														 game_name: game_info[:name],
														 started_at: DateTime.now
														)
				end
			end
		end
	end
end
