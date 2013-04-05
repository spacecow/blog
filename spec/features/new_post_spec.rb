require 'spec_helper'

describe 'Post new' do
  before{ visit new_post_path }

  it "create" do
    fill_in 'Content', with:'some content'
    click_button 'Create'
  end
end
