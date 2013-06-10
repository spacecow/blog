class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence:true, uniqueness:true
  validates :email, format:{with:/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/}, if:"email.present?"
  validates :username, presence:true

  def password_confirmation
    @confirmation
  end

  def password_confirmation=(s)
    @confirmation = s 
  end
end
