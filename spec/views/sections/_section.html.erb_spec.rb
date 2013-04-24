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
  it{ should have_selector 'span.tags' }

  it{ should have_selector 'div.actions.section a.view.section', count:2 }
  it{ should have_selector 'div.actions.section a.edit.section', count:2 }
  it{ should have_selector 'div.actions.section a.delete.section', count:2 }
end
