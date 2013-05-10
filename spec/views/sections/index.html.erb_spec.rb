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

  it{ should have_selector 'div.actions.sections a.new.section', count:2 }
end
