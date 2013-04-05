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

    context 'Content' do
      subject{ rendering.find_field 'Content' } 
      its(:value){ should be_blank }
    end

    context 'Tags' do
      subject{ rendering.find_field 'Tags' } 
      its(:value){ should be_nil }
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

    context 'Content' do
      subject{ rendering.find_field 'Content' } 
      its(:value){ should eq 'description' }
    end

    context 'Tags' do
      subject{ rendering.find_field 'Tags' } 
      its(:value){ should be_nil }
    end
  end
end
