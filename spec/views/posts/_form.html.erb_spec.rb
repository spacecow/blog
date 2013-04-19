require 'spec_helper'

describe 'posts/_form.html.erb' do
  let(:rendering){ Capybara.string rendered }

  context 'new post' do
    let(:post){ Post.new }
    before do
      post.sections.build
      render 'posts/form', post:post
    end

    context 'Title' do
      subject{ rendering.find_field 'Title' } 
      its(:value){ should be_nil }
    end

    subject{ rendering }
    it{ should have_field 'Content', count:1 }
    it{ should have_field 'Tags', count:1 }
  
    context "add section" do
      subject{ rendering.find 'a.add_fields' }
      its(:text){ should eq 'Add Section' }
    end
  end

  context "edit post" do
    let(:post){ create :post, title:'oh yeah' }
    before do
      post.sections.create content:'description'
      render 'posts/form', post:post
    end

    context 'Title' do
      subject{ rendering.find_field 'Title' } 
      its(:value){ should eq 'oh yeah' }
    end

    subject{ rendering }
    it{ should have_field 'Content', count:1 }
    it{ should have_field 'Tags', count:1 }
  end
end
