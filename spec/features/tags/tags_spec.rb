require 'spec_helper'

describe 'tags/index.html.erb' do
  before{ visit tags_path }
  it{ page.find('.active').text.should eq 'Tags' } 
end
