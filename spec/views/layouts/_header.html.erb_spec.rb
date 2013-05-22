require 'spec_helper'

describe 'layouts/_header.html.erb' do
  let(:rendering){ Capybara.string rendered }
  before{ render 'layouts/header' }

  describe 'navigation' do
    describe 'first link' do
      subject{ rendering.find('header nav').all('ul li a')[0] }
      its(:text){ should eq 'Posts' }
      specify{ subject[:href].should eq posts_path }
    end

    describe 'second link' do
      subject{ rendering.find('header nav').all('ul li a')[1] }
      its(:text){ should eq 'Sections' }
      specify{ subject[:href].should eq sections_path }
    end

    describe 'third link' do
      subject{ rendering.find('header nav').all('ul li a')[2] }
      its(:text){ should eq 'Tags' }
      specify{ subject[:href].should eq tags_path }
    end
  end
end
