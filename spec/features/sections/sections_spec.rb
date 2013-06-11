require 'spec_helper'

describe 'sections/index.html.erb' do
  before{ visit sections_path }
  it{ page.find('.active').text.should eq 'Sections' } 
end
