require 'spec_helper'

describe 'layouts/_navigation.html.erb' do
  let(:rendering){ Capybara.string rendered }
  before do
    view.content_for(:current_tab){ 'Posts' }
    render 'layouts/navigation.html.erb'
  end

  describe 'active tab' do
    subject{ rendering.find('li.active a') }
    its(:text){ should eq 'Posts' }
    specify{ subject[:href].should eq posts_path }
  end

  describe 'first inactive tab' do
    subject{ rendering.all('li.inactive a')[0] }
    its(:text){ should eq 'Sections' }
    specify{ subject[:href].should eq sections_path }
  end

  describe 'second inactive tab' do
    subject{ rendering.all('li.inactive a')[1] }
    its(:text){ should eq 'Tags' }
    specify{ subject[:href].should eq tags_path }
  end
end
