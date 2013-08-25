class User < ActiveRecord::Base
  belongs_to :seat

  private
  def ip
    self[:ip]
  end

  def ip=(val)
    write_attribute :ip, val
  end
end
