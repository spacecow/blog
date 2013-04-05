require 'spec_helper'

describe 'posts/show.html.erb' do
  let(:section){ mock_model Section }
  let(:post){ mock_model Post }
  before do
    post.should_receive(:sections).and_return [section]
    assign :post, post
    render
  end

  subject{ Capybara.string(rendered).find('div.post.show') }
  it{ should have_selector 'h1' }
  it{ should have_selector 'div.sections' }
end
