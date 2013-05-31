require 'spec_helper'

describe 'Section new, directly' do
  before do
    visit new_section_path
    fill_in 'Content', with:'some content'
    fill_in 'Tags', with:'<<<ruby>>>'
  end

  it{ lambda{ click_button 'Create' }.should change(Section,:count).by(1) }

  context "last section" do
    before{ click_button 'Create' }
    subject{ Section.last }
    its(:content){ should eq 'some content' }
    its(:post_id){ should be_nil }
  end

  it "flash appears" do
    click_button 'Create'
    page.should have_text 'created'
  end

  context 'content blank' do
    before{ fill_in 'Content', with:'' }
    it{ lambda{ click_button 'Create' }.should change(Section,:count).by(0) }
  end
end

describe 'Section new, indirectly from Tag show' do
  let(:ruby){ create :tag, name:'ruby' }
  before do
    visit tag_path ruby
    click_link 'New Section'
  end

  it{ find_field('Tags').value.should eq ruby.id.to_s }
end
