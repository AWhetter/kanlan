class User < ActiveRecord::Base
  attr_accessible :username, :comment, :id

  validates :id, :presence => true, :uniqueness => true
  validates :username, :presence => true, :uniqueness => true

  has_many :posts

  def self.authenticate(username, userid)
    begin
      user = User.find(userid)
    rescue ActiveRecord::RecordNotFound
      return nil
    end

    if user.username == username
      user
    else
      nil
    end
  end
end
