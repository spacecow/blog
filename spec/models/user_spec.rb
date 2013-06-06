require 'spec_helper'

describe User do
  let(:user){ stub_model User }
  subject{ user }
  it{ should respond_to :email }
  it{ should respond_to :username }
  it{ should respond_to :roles_mask }
  it{ should respond_to :password }
  it{ should respond_to :password_confirmation }
  it{ should respond_to :password_digest }

  it 'email cannot be blank' do
    expect{ create :user, email:'' }.to raise_error *blank_error
  end

  it 'email must be unique' do
    create :user, email:'test@ex.com'
    expect{ create :user, email:'test@ex.com' }.to raise_error *duplication_error
  end

  it 'username cannot be blank' do
    expect{ create :user, username:'' }.to raise_error *blank_error
  end

  it 'username must be unique' do
    create :user, username:'test'
    expect{ create :user, username:'test' }.to raise_error *duplication_error
  end

  it 'password cannot be blank' do
    expect{ create :user, password:'' }.to raise_error *blank_error
  end

  it 'password confirmation cannot be blank' do
    expect{ create :user, password_confirmation:'' }.to raise_error *confirmation_error
  end

  def blank_error
    [ActiveRecord::RecordInvalid, /^Validation failed: [\w ]+ can't be blank$/]
  end

  def confirmation_error
    [ActiveRecord::RecordInvalid, /^Validation failed: [\w ]+ doesn\'t match [\w ]+$/]
  end

  def duplication_error
    [ActiveRecord::RecordInvalid, /^Validation failed: [\w ]+ has already been taken$/]
  end
end
