class Post < ActiveRecord::Base
  belongs_to :game

  def <=>(other)
    self.game <=> other.game
  end
end
