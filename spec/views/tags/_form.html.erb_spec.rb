require 'spec_helper'

describe 'tags/_form.html.erb' do
  context 'edit tag' do
    let(:tag){ stub_model Tag, name:'ruby' }
    let(:rendering){ Capybara.string rendered }
    before do
      render 'tags/form', tag:tag
    end

    describe "Name field" do
      subject{ rendering.find_field 'Name' }
      its(:value){ should eq 'ruby' }
    end
  end
end
