class Post < ActiveRecord::Base
  validates :game, :presence => true
  belongs_to :game

  def <=>(other)
    self.game <=> other.game
  end
end
