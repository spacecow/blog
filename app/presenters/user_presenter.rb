class UserPresenter < BasePresenter
  presents :user

  def signup_form
    @signup_form = SignupForm.new user
  end
end
