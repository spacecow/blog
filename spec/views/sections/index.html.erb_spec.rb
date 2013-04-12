require 'spec_helper'

describe 'sections/index.html.erb' do
  let(:section){ stub_model Section }
  let(:rendering){ Capybara.string rendered }
  before do
    assign :sections, [section]
    render
  end

  subject{ rendering }
  it{ should have_selector 'div.sections' }

  describe 'actions' do
    subject{ rendering.find 'div.actions.sections' }
    it{ should have_selector 'a.new.section' }
  end
end
