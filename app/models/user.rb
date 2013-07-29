class User < ActiveRecord::Base
  private
  def ip
    self[:ip]
  end

  def ip=(val)
    write_attribute :ip, val
  end
end
