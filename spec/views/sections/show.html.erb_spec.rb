require 'spec_helper'

describe 'sections/show.html.erb' do
  let(:section){ stub_model Section }
  let(:rendering){ Capybara.string rendered }
  before do
    assign :section, section
    render
  end

  subject{ rendering }
  it{ should have_selector 'h1' }
  it{ should have_selector 'span.tags' }
  it{ should have_selector 'div.content' }

  it{ should have_selector 'div.actions.section a.edit.section', count:2 }
  it{ should have_selector 'div.actions.section a.delete.section', count:2 }
end
