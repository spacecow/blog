require 'spec_helper'

describe 'sections/_form.html.erb' do
  context 'edit post' do
    let(:section){ stub_model Section, content:'some content' }
    let(:tag){ stub_model Tag }
    let(:rendering){ Capybara.string rendered }
    before do
      create :post, title:'the wonder of life'
      section.tags << tag
      render 'sections/form', section:section
    end

    subject{ rendering }
    it{ should have_select 'Post', with_options:['the wonder of life'] }

    describe "Content field" do
      subject{ rendering.find_field 'Content' }
      its(:value){ should eq 'some content' }
    end

    describe "Tags field" do
      subject{ rendering.find_field 'Tags' }
      its(:value){ should eq tag.id.to_s }
    end
  end
end
