class PlaySession < ActiveRecord::Base
  belongs_to :user

	validates :game_name, presence: true
	validates :user, presence: true
	validates :started_at, presence: true
end
