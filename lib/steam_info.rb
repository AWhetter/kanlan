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
			Rails.logger.debug "Getting remote information about #{uids}"
			to_return = []
			uids.each_slice(64) do |uids_64|
				to_return << JSON.parse(open("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=#{Devise.omniauth_configs[:steam].strategy.api_key}&steamids=#{uids_64.join ','}").read)["response"]["players"]
			end
			to_return.flatten
		end

		def self.cache_all
			uids = User.where(provider: 'steam').select(:uid).uniq.pluck(:uid)
			Rails.cache.write(:steam_cache_updated_at, DateTime.now)
		end

		def self.cache_uids(*uids)
			remote_user_info(*uids).each do |user_info|
				Rails.cache.write([:steam_user_info, user_info['steamid']],
													user_info,
													expires_in: 5.minutes
												 )
			end
		end

		def self.get(uids, *param_list)
			to_return = {}
			uids.each do |uid|
				user_info = Rails.cache.fetch [:steam_user_info, uid], expires_in: 5.minutes do
					remote_user_info(uid)[0]
				end

				to_return[uid] = get_from_info_hash user_info, *param_list
			end

			to_return
		end

		def self.get_from_info_hash(user_info, *param_list)
			to_return = {}
			param_list.each do |param|
				to_return[param] = UserInfo.method(param).call user_info
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
				game_info = game_info[:playing]
				user = User.where(uid: uid).first
				if user.nil?
					Rails.logger.warn "Got information from Steam about an unknown user"
					next
				end

				current_session = PlaySession.where(user: user).order(:created_at).last
				if current_session
					# If in the same session
					if current_session.steam_app_id == game_info[:id] and current_session.game_name == game_info[:name]
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

			sessions = PlaySession.where(finished_at: nil)
			# Get the database to do the sorting for us
			game_counts = sessions.group(:game_name).count
			now_playing = {}
			# Iterate in sorted order
			game_counts.each_key do |name|
				now_playing[name] = sessions.where(game_name: name).map(&:user)
			end

			Rails.cache.write :now_playing, now_playing
			ActionController::Base.new.expire_fragment('now_playing')
		end
	end
end
