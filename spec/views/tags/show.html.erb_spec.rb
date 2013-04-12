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

  describe 'actions' do
    subject{ rendering.find 'div.actions.tag' }
    it{ should have_selector 'a.edit.tag' }
  end
end
