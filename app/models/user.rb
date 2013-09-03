class User < ActiveRecord::Base
  belongs_to :seat

  validates_uniqueness_of :ip
  validates_presence_of :seat
  validates_presence_of :username
  validates_uniqueness_of :username

  def ==(other)
    (other.is_a? User) and (self.username == other.username)
  end

  private
  def ip
    self[:ip]
  end

  def ip=(val)
    write_attribute :ip, val
  end
end
