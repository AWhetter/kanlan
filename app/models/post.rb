class Post < ActiveRecord::Base
  attr_accessible :user, :game
  attr_accessor :game

  belongs_to :user
  has_and_belongs_to_many :games

  def assign_game new_game
    self.games = [Game.find(new_game)]
  end
end
