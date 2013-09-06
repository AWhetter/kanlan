class Post < ActiveRecord::Base
  belongs_to :game
  has_and_belongs_to_many :users, :before_add => :validates_user

  validates_presence_of :game
  validates_uniqueness_of :params, :scope => [:game]

  def <=>(other)
    self.game <=> other.game
  end

  def add_user(user)
    self.users << user
  end

  private
  def validates_user(user)
    raise ActiveRecord::Rollback if self.users.include? user
  end
end
