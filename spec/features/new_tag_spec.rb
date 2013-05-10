require 'spec_helper'

describe 'Tag new' do
  before do
    visit new_tag_path
    fill_in 'Name', with:'ruby'
  end

  it{ lambda{ click_button 'Create' }.should change(Tag,:count).by(1) }

  context "last tag" do
    before{ click_button 'Create' }
    subject{ Tag.last }
    its(:name){ should eq 'ruby' }
  end
end
