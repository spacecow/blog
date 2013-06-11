require 'spec_helper'

describe 'tags/_tag.html.erb' do
  let(:tag){ stub_model Tag, name:'language/ruby' }
  let(:rendering){ Capybara.string rendered }
  before{ render 'tags/tag', tag:tag }

  it{ rendering.should have_selector 'li.tag.title' }
  it{ rendering.find('li.tag.title').text.should eq 'ruby' }
end
