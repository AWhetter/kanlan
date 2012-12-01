class Game < ActiveRecord::Base
  attr_accessible :name, :url, :user

  belongs_to :user
  has_and_belongs_to_many :posts

  def this
    self
  end
end