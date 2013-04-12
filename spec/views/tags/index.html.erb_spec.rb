require 'spec_helper'

describe 'tags/index.html.erb' do
  before do
    render
  end

  subject{ Capybara.string rendered }
  it{ should have_selector 'div.tags.cloud' }
end
