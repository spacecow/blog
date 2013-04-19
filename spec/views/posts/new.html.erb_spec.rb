require 'spec_helper'

describe 'posts/new.html.erb' do
  let(:post){ stub_model(Post).as_new_record }
  before do
    assign :post, post
    render
  end

  subject{ Capybara.string(rendered).find('div.post.new') }
  it{ should have_selector 'h1', text:'New Post' }
  it{ should have_selector 'form.new_post' }
end
