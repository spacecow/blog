require 'spec_helper'

describe 'users/new.html.erb' do
  let(:user){ User.new }
  let(:signup_form){ SignupForm.new user }
  before do
    assign :signup_form, signup_form
    render
  end

  specify{ rendered.should have_selector 'div.user.new' } 
end 
