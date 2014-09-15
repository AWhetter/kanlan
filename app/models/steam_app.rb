class SteamApp < ActiveRecord::Base
	def url
		"http://store.steampowered.com/app/#{id}/"
	end
end
