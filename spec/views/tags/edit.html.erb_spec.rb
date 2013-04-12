require 'spec_helper'

describe 'tags/edit.html.erb' do
  let(:rendering){ Capybara.string rendered }
  let(:tag){ create :tag, name:'perl' }
  before do
    create :tag, name:'ruby'
    assign :tag, tag
    render
  end

  describe 'Parent' do
    subject{ rendering.find_field 'Parent' }
    its(:text){ should eq 'ruby' }
  end
end
