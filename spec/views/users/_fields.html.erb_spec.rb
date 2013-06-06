require 'spec_helper'

describe 'users/_fields.html.erb' do
  let(:rendering){ Capybara.string rendered }

  describe 'new user' do
    let(:user){ mock_model(User).as_new_record }
    before do
      view.simple_form_for(user){|f| @f=f}
      user.should_receive(:disabled?).and_return disabled:false
      render 'users/fields', f:@f
    end

    it 'name field is blank' do
      rendering.find_field('Username').value.should be_blank
    end

    it 'email field is blank' do
      rendering.find_field('Email').value.should be_blank
    end

    it 'password field is blank' do
      rendering.find_field('Password').value.should be_blank
    end

    it 'password confirmation field is blank' do
      rendering.find_field('Confirmation').value.should be_blank
    end
  end

  describe 'edit user' do
    let(:user){ mock_model User, username:'tester', email:'test@ex.com' }
    before do
      view.simple_form_for(user){|f| @f=f}
      user.should_receive(:disabled?).and_return disabled:true
      render 'users/fields', f:@f
    end

    describe 'username field' do
      subject{ rendering.find 'div.user_username' }
      it{ should have_selector 'input.disabled' }
      specify{ subject.find('input').value.should eq 'tester' }
    end

    it 'email field is filled in' do
      rendering.find_field('Email').value.should eq 'test@ex.com' 
    end

    it 'password field is not displayed' do
      rendering.should_not have_selector('div.user_password')
    end

    it 'password confirmation field is not displayed' do
      rendering.should_not have_selector('div.user_password_confirmation')
    end
  end
end
