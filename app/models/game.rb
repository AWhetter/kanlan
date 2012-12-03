class Game < ActiveRecord::Base
  attr_accessible :name, :url

  has_and_belongs_to_many :posts

  def this
    self
  end
end
