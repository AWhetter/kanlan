class Post < ActiveRecord::Base
  validates_presence_of :game
  validates_uniqueness_of :params, :scope => [:game]

  belongs_to :game

  def <=>(other)
    self.game <=> other.game
  end
end
