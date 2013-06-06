require 'spec_helper'

describe 'Users new' do
  before do
    visit new_user_path
    fill_in 'Username', with:'tester'
    fill_in 'Email', with:'test@example.com'
    fill_in 'Password', with:'foobar'
    fill_in 'Confirmation', with:'foobar'
  end

  it 'saves a user to db' do
    expect{ click_button 'Signup' }.to change(User,:count).by(1)
  end

  describe 'success' do
    before{ click_button 'Signup' }

    describe 'created user' do
      subject{ User.last }
      its(:username){ should eq 'tester' }
      its(:email){ should eq 'test@example.com' }
    end
  end

  it 'failure' do
    fill_in 'Password', with:'barfoo'
    click_button 'Signup'
  end
end
