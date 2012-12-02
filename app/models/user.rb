class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :comment
  attr_accessor :password
  before_save :encrypt_password

  validates :password, :presence => true, :confirmation => true, :on => :create
  validates :password, :presence => true, :confirmation => true, :on => :update, :unless => lambda{ |user| user.password.blank? }
  validates :username, :presence => true, :uniqueness => true;

  has_many :posts
  has_many :games

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
