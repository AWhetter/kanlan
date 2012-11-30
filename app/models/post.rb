class Post < ActiveRecord::Base
  attr_accessible :user, :game_id

  belongs_to :user
  has_and_belongs_to_many :games
end
