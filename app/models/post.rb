class Post < ActiveRecord::Base
  attr_accessible :users, :game, :params

  validates :game, :presence => true
  validates :params, :length => {:maximum => 80}

  has_and_belongs_to_many :users
  belongs_to :game
end
