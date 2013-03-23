class Game < ActiveRecord::Base
  attr_accessible :name, :url

  validates :name, :presence => true, :length => { :maximum => 40 }
  validates :url, :length => { :maximum => 200 }

  has_many :posts
  belongs_to :user

  def this
    self
  end
end
