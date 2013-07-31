class Game < ActiveRecord::Base
  has_many :posts

  def <=>(other)
    self.name <=> other.name
  end
end
