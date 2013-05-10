require 'spec_helper'

describe 'posts/index.html.erb' do
  let(:post){ mock_model Post }
  let(:rendering){ Capybara.string rendered }
  before do
    assign :posts, [post]
    render
  end

  subject{ rendering.find 'ul.posts' }
  it{ should have_selector 'li.post', count:1 }

  describe 'actions' do
    subject{ rendering.find 'div.actions.posts' }
    it{ should have_selector 'a.new.post' }
  end
end
