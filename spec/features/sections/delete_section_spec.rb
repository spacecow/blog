require 'spec_helper'

describe 'Section delete', focus:true do
  let(:click_delete_section){ all('a.delete.section').first.click }

  context 'on section page' do
    let(:section){ create :section }
    before do
      section.tags << create(:tag)
      visit section_path section
    end

    it "deletes the section" do
      expect{ click_delete_section }.to change(Section,:count).by(-1)
    end
    it "deletes its taggings" do
      expect{ click_delete_section }.to change(Tagging,:count).by(-1)
    end
    it "does not delete the tag" do
      expect{ click_delete_section }.to change(Tag,:count).by(0)
    end

    it "redirects to the sections index page" do
      click_delete_section
      current_path.should eq sections_path
    end
  end

  context 'on post page' do
    let(:post){ create :post }
    before do
      post.sections << create(:section)
      visit post_path post
    end

    it "deletes the section" do
      expect{ click_delete_section }.to change(Section,:count).by(-1)
    end
    it "does not delete the post" do
      expect{ click_delete_section }.to change(Post,:count).by(0)
    end

    it "redirects to the post page" do
      click_delete_section
      current_path.should eq post_path(post)
    end
  end

  context "on tag page" do
    let(:tag){ create :tag }
    before do
      tag.sections << create(:section)
      visit tag_path tag
    end

    it "deletes the section" do
      expect{ click_delete_section }.to change(Section,:count).by(-1)
    end
    it "deletes its taggings" do
      expect{ click_delete_section }.to change(Tagging,:count).by(-1)
    end
    it "does not delete the tag" do
      expect{ click_delete_section }.to change(Tag,:count).by(0)
    end

    it "redirects to the tag page" do
      click_delete_section
      current_path.should eq tag_path(tag)
    end
  end
end
