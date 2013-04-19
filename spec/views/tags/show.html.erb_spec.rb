require 'spec_helper'

describe 'tags/show.html.erb' do
  let(:tag){ stub_model Tag }
  let(:rendering){ Capybara.string(rendered) }
  before do
    assign :tag, tag
    render
  end

  subject{ rendering.find 'div.tag.show' }
  it{ should have_selector 'div.sections' } 

  it{ should have_selector 'div.actions.tag a.edit.tag', count:2 }
end
