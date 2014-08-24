class Game < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :url, format: {with: URI::regexp(['http', 'https'])}, allow_blank: true
	validates :steam_app_id, uniqueness: true, allow_blank: true
end
