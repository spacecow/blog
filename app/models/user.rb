class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence:true, uniqueness:true
  validates :username, presence:true

  def password_confirmation
    @confirmation
  end

  def password_confirmation=(s)
    @confirmation = s 
  end
end
