require 'spec_helper'

describe 'Post edit' do
  let(:post){ create :post }
  before do
    create :section, post:post
    visit edit_post_path(post)
    fill_in 'Title', with:'some edited title'
    fill_in 'Content', with:'some edited content'
  end

  it{ lambda{ click_button 'Update' }.should change(Post,:count).by(0) }
  it{ lambda{ click_button 'Update' }.should change(Section,:count).by(0) }

  context "last post" do
    before{ click_button 'Update' }
    subject{ Post.last }
    its(:title){ should eq 'some edited title' }
  end

  context "last section" do
    before{ click_button 'Update' }
    subject{ Section.last }
    its(:content){ should eq 'some edited content' }
    its(:post_id){ should be Post.last.id }
  end
end
