require 'spec_helper'

describe 'Section edit' do
  let(:section){ create :section }
  before do
    visit edit_section_path section
    fill_in 'Content', with:'some edited content'
    fill_in 'Tags', with:'<<<ruby>>>'
  end

  it{ lambda{ click_button 'Update' }.should change(Section,:count).by(0) }

  context "last section" do
    before{ click_button 'Update' }
    subject{ Section.last }
    its(:content){ should eq 'some edited content' }
    its(:tag_ids){ should eq [Tag.last.id] }
  end
end
