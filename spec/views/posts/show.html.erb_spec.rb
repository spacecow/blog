require 'spec_helper'

describe 'posts/show.html.erb' do
  let(:section){ stub_model Section }
  let(:post){ mock_model Post }
  let(:rendering){ Capybara.string(rendered).find 'div.post.show' }
  before do
    post.should_receive(:sections).and_return [section]
    assign :post, post
    render
  end

  subject{ rendering }
  it{ should have_selector 'h1' }
  it{ should have_selector 'div.sections' }

  describe 'actions' do
    subject{ rendering.find 'div.actions.post' }
    it{ should have_selector 'a.edit.post' }
  end
end
