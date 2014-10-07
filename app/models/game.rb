class Game < ActiveRecord::Base
	has_many :posts, dependent: :destroy

	before_validation do
		url = SteamInfo::GameInfo::url_from_id(steam_app_id) unless steam_app_id.nil?
	end

	validates :name, presence: true, uniqueness: true
	validates :url, format: {with: URI::regexp(['http', 'https'])}, allow_blank: true
	validates :steam_app_id, uniqueness: true, allow_blank: true
	validate :valid_steam_app_if_has_steam_app_id

	def <=>(other)
		self.name <=> other.name
	end

	def valid_steam_app_if_has_steam_app_id
		return if steam_app_id.nil?
		if SteamApp.find_by(id: steam_app_id, name: name).nil?
			if SteamApp.find_by(id: steam_app_id)
				errors.add(name: "is not correct for this steam app id")
			elsif SteamApp.find_by(name: name)
				errors.add(id: "is incorrect for this game")
			else
				errors.add(:id, "is not a valid steam app id")
				errors.add(:name, "is not a valid steam game name")
			end
		end
	end
end
