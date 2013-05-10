require 'spec_helper'

describe 'tags/new.html.erb' do
  let(:tag){ stub_model(Tag).as_new_record }
  before do
    assign :tag, tag
    render
  end

  subject{ Capybara.string(rendered).find('div.tag.new') }
  it{ should have_selector 'h1', text:'New Tag' }
  it{ should have_selector 'form.new_tag' }
end
