class PlaySession < ActiveRecord::Base
  belongs_to :user

	validates :game_name, presence: true, if: Proc.new {|a| a.steam_app_id.nil?}
	validates :user, presence: true
	validates :started_at, presence: true
end
