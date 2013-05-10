require 'spec_helper'

describe 'Section delete' do
  context 'on section page' do
    let(:section){ create :section }
    before do
      section.tags << create(:tag)
      visit section_path section
    end

    it{ lambda{ first(:link,'Delete').click }.should change(Section,:count).by(-1) }
    it{ lambda{ first(:link,'Delete').click }.should change(Tagging,:count).by(-1) }

    context 'redirect' do
      before{ first(:link,'Delete').click }
      subject{ page }
      its(:current_path){ should eq sections_path }
    end
  end

  context 'on post page' do
    let(:post){ create :post }
    before do
      post.sections << create(:section)
      visit post_path post
    end

    it{ lambda{ first(:link,'Delete').click }.should change(Section,:count).by(-1) }

    context 'redirect' do
      before{ first(:link,'Delete').click }
      subject{ page }
      its(:current_path){ should eq post_path(post) }
    end
  end
end
