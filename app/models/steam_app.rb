class SteamApp < ActiveRecord::Base
	def url
		SteamInfo::GameInfo::url_from_id id
	end
end
