require 'spec_helper'

describe 'tags/_tags.html.erb' do
  let(:tag){ stub_model Tag }
  let(:rendering){ Capybara.string rendered }
  before{ render 'tags/tags', tags:[tag] }

  subject{ rendering }
  it{ should have_selector 'ul.tags.inline' }
end
