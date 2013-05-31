require 'spec_helper'

describe 'tags/show.html.erb' do
  let(:tag){ stub_model Tag }
  let(:presenter){ stub.as_null_object }
  before do
    assign :tag, tag
    view.should_receive(:present).with(tag).and_yield presenter
  end

  it "list its sections" do
    presenter.should_receive(:sections).once
    render
  end

  it "has top and bottom edit&delete links" do
    presenter.should_receive(:actions).with(:edit, :delete).twice
    render
  end

  it "has a new section link with the presenter"

  it "has a new section link" do
    render
    rendered.should have_text 'New Section'
  end
end
