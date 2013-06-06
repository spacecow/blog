require 'spec_helper'

describe UsersController do
  context 'create a user' do
    let(:form){ mock }
    before{ SignupForm.should_receive(:new).and_return form }

    context 'saves to db' do
      before do
        form.should_receive(:submit).and_return true
        post :create, user:{email:'test@ex.com'}
      end

      specify{ response.should redirect_to root_url }
      specify{ flash.notice.should eq 'User signed up' }
    end

    context 'error' do
      before do
        form.should_receive(:submit).and_return false
        post :create, user:{email:'test@ex.com'}
      end

      specify{ response.should render_template :new }
    end
  end
end
