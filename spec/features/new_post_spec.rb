require 'spec_helper'

describe 'Post new' do
  before do
    visit new_post_path
    fill_in 'Title', with:'some title'
    fill_in 'Content', with:'some content'
  end

  it{ lambda{ click_button 'Create' }.should change(Post,:count).by(1) }
  it{ lambda{ click_button 'Create' }.should change(Section,:count).by(1) }

  context 'content blank' do
    before do
      fill_in 'Content', with:''
    end

    it{ lambda{ click_button 'Create' }.should change(Post,:count).by(1) }
    it{ lambda{ click_button 'Create' }.should change(Section,:count).by(0) }
  end
end
