require 'spec_helper'

describe 'tags/new.html.erb' do
  let(:tag){ mock_model(Tag).as_new_record }
  let(:presenter){ stub.as_null_object }
  before do
    assign :tag, tag
    view.should_receive(:present).with(tag).and_yield presenter
  end

  it "displays a title" do
    render
    Capybara.string(rendered).find('div.tag.new').find('h1').text.should eq 'New Tag'
  end

  it "renders a form" do
    presenter.should_receive(:form)
    render
  end
end
