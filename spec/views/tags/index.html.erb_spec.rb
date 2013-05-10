require 'spec_helper'

describe 'tags/index.html.erb' do
  let(:rendering){ Capybara.string rendered }
  before{ render }

  subject{ rendering }
  it{ should have_selector 'div.tags.cloud' }

  describe 'actions' do
    subject{ rendering.find 'div.actions.tags' }
    it{ should have_selector 'a.new.tag' }
  end
end
