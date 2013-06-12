require 'spec_helper'

describe 'Tag edit', focus:true do
  let(:tag){ create :tag, name:'programming/python' }
  let!(:parent){ create :tag, name:'programming' }
  before do
    visit edit_tag_path tag
    fill_in 'Name', with:'ruby'
    select 'programming', from:'Parent'
  end

  it{ lambda{ click_button 'Update' }.should change(Section,:count).by(0) }

  context "last tag" do
    before{ click_button 'Update' }
    subject{ Tag.last }
    its(:name){ should eq 'programming/ruby' }
    its(:ancestry){ should eq parent.id.to_s }
  end
end
