class User < ActiveRecord::Base
  belongs_to :seat
  has_and_belongs_to_many :posts, -> { where uniq: true }, :before_add => :validates_post

  validates_uniqueness_of :ip
  validates_presence_of :seat
  validates_presence_of :username
  validates_uniqueness_of :username

  def ==(other)
    (other.is_a? User) and (self.username == other.username)
  end

  private
  def validates_posts(post)
    raise ActiveRecord::Rollback if self.posts.include? post
  end
end
