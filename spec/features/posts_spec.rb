require 'spec_helper'

describe 'posts/index.html.erb' do
  before{ visit posts_path }
  it{ page.find('.active').text.should eq 'Posts' } 
end
