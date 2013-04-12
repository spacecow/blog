require 'spec_helper'

describe 'sections/show.html.erb' do
  let(:section){ stub_model Section }
  let(:rendering){ Capybara.string rendered }
  before do
    assign :section, section
    render
  end

  subject{ rendering }
  it{ should have_selector 'div.content' }
  it{ should have_selector 'div.tags' }

  describe 'actions' do
    subject{ rendering.find 'div.actions.section' }
    it{ should have_selector 'a.edit.section' }
    it{ should have_selector 'a.delete.section' }
  end
end
