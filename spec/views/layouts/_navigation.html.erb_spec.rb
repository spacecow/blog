require 'spec_helper'

describe 'layouts/_navigation.html.erb', focus:true do
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

  describe 'inactive tab' do
    subject{ rendering.find('li.inactive a') }
    its(:text){ should eq 'Sections' }
    specify{ subject[:href].should eq sections_path }
  end
end
