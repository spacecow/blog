class UsersController < ApplicationController
  def new
    user = User.new
    @signup_form = SignupForm.new user
  end

  def create
    user = User.new
    @signup_form = SignupForm.new user
    if @signup_form.submit(user_params)
      redirect_to root_url, notice:signed_up(:user)
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit :username, :email, :password, :password_confirmation
    end
end
