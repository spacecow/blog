class SignupForm
  include ActiveModel::Model

  delegate :username, :email, :password, :password_confirmation, :new_record?, to: :user

  def initialize user
    @user = user
  end
  def user; @user end

  def disabled?
    {disabled:user.new_record? ? false : true}
  end

  def submit params
    user.attributes = params
    user.save! if user.valid?
  end

  class << self
    def model_name
      ActiveModel::Name.new(self, nil, "User")
    end
  end
end
