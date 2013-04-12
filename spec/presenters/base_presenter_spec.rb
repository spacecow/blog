require 'spec_helper'

describe BasePresenter do
  let(:post){ mock_model Post }
  let(:presenter){ BasePresenter.new(post,view) }

  describe '#actions' do
    context 'one action' do
      let(:rendering){ Capybara.string presenter.actions :edit }
      subject{ rendering }
      its(:text){ should eq 'Edit Post' }

      describe 'edit link' do
        subject{ rendering.find 'a.edit.post' }
        its(:text){ should eq 'Edit Post' }
        specify{ subject[:href].should eq edit_post_path post }
      end
    end

    context 'two actions' do
      let(:rendering){ Capybara.string presenter.actions :view, :edit }
      subject{ rendering }
      its(:text){ should eq '(View | Edit) Post' }

      describe 'view link' do
        subject{ rendering.find 'a.view.post' }
        its(:text){ should eq 'View' }
        specify{ subject[:href].should eq post_path post }
      end

      describe 'edit link' do
        subject{ rendering.find 'a.edit.post' }
        its(:text){ should eq 'Edit' }
        specify{ subject[:href].should eq edit_post_path post }
      end
    end
  end

  describe '#delete_link' do
    let(:rendered){ Capybara.string presenter.delete_link }  
    subject{ rendered }
    its(:text){ should eq 'Delete Post' }

    context 'link' do
      subject{ rendered.find('a') }
      it{ subject[:href].should eq post_path post }
      it{ subject['data-method'].should eq 'delete' }
    end
  end

  describe '#edit_link' do
    let(:rendered){ Capybara.string presenter.edit_link }  
    subject{ rendered }
    its(:text){ should eq 'Edit Post' }

    context 'link' do
      subject{ rendered.find('a') }
      it{ subject[:href].should eq edit_post_path(post) }
    end
  end
end
