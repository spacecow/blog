require 'spec_helper'

describe 'posts/edit.html.erb' do
  before do
    assign :post, stub_model(Post)
    render
  end

  subject{ Capybara.string(rendered).find('div.post.edit') }
  it{ should have_selector 'h1', text:'Edit Post' }
  it{ should have_selector 'form.edit_post' }
end
