class Post < ActiveRecord::Base
  attr_accessible :users, :game

  has_and_belongs_to_many :users
  belongs_to :game
end
