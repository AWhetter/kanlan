class User < ActiveRecord::Base
  attr_accessible :username, :comment, :ip, :table, :seat

  validates :ip, :presence => true, :uniqueness => true
  validates :username, :presence => true, :uniqueness => true, :length => { :maximum => 20 }
  validates :table, :presence => true
  validates :seat, :presence => true

  has_many :posts

  def self.authenticate(username, ip)
    user = User.find_by_ip(ip)

    if user != nil and user.username == username
      user
    else
      nil
    end
  end
end
