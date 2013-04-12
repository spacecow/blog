require 'spec_helper'

describe 'sections/_section.html.erb' do
  let(:section){ mock_model Section }
  let(:rendering){ Capybara.string rendered }
  before do
    section.should_receive(:tags).and_return [] 
    render section
  end

  subject{ rendering }
  it{ should have_selector 'div.content' }
  it{ should have_selector 'div.tags' }

  describe 'actions' do
    subject{ rendering.find 'div.actions.section' }
    it{ should have_selector 'a.view' }
    it{ should have_selector 'a.edit' }
    it{ should have_selector 'a.delete' }
  end
end
