require 'spec_helper'

describe SignupForm do
  let(:user){ User.new }
  let(:form){ SignupForm.new user }
  subject{ form }
  it{ should respond_to :email }
  it{ should respond_to :username }
  it{ should respond_to :password }
  it{ should respond_to :password_confirmation }

  describe "#submit" do
    it "proper submition creates a user" do
      expect{ form.submit username:'tester', email:'test@example.com', password:'foobar'}.to change(User,:count).by(1)
    end
  end
end
