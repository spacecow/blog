require 'spec_helper'

describe 'Tag edit' do
  let(:tag){ create :tag }
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
    its(:name){ should eq 'ruby' }
    its(:ancestry){ should eq parent.id.to_s }
  end
end
