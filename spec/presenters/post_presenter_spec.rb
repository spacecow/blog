require 'spec_helper'

describe PostPresenter do
  let(:post){ mock_model Post }
  let(:presenter){ PostPresenter.new(post,view) }
  subject{ rendered }

  describe '#edit_link' do
    let(:rendered){ Capybara.string presenter.edit_link }  
    its(:text){ should eq 'Edit Post' }

    context 'link' do
      subject{ rendered.find('a') }
      it{ subject[:href].should eq edit_post_path(post) }
    end
  end

  context "#title" do
    let(:rendered){ Capybara.string presenter.title }
    before{ post.should_receive(:title).and_return 'yeah' }
    its(:text){ should eq 'yeah' }
  end
end
