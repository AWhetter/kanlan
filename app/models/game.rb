class Game < ActiveRecord::Base
  attr_accessible :name, :url

  validates :name, :presence => true, :length => { :maximum => 30 }
  validates :url, :length => { :maximum => 200 }

  has_and_belongs_to_many :posts

  def this
    self
  end
end
