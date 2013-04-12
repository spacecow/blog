require 'spec_helper'

describe PostPresenter do
  let(:post){ mock_model Post }
  let(:presenter){ PostPresenter.new(post,view) }

  context "#title" do
    before{ post.should_receive(:title).and_return 'yeah' }

    context "as header" do
      subject{ Capybara.string presenter.title }
      its(:text){ should eq 'yeah' }
    end

    context "as link" do
      let(:rendered){ Capybara.string presenter.title as: :link }
      subject{ rendered }
      its(:text){ should eq 'yeah' }

      describe "link" do
        subject{ rendered.find 'a' }
        specify{ subject[:href].should eq post_path post }
      end
    end
  end
end
