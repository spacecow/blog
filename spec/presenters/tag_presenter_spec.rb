require 'spec_helper'

describe TagPresenter do
  let(:tag){ stub_model Tag, name:'ruby' }
  let(:presenter){ TagPresenter.new tag,view }

  describe '#branch' do
    before do
      tag.should_receive(:branch).and_return [tag]
    end
    subject{ Capybara.string presenter.branch }
    its(:text){ should eq 'ruby' } 

    describe 'link' do
      subject{ Capybara.string(presenter.branch).find('a') }
      its(:text){ should eq 'ruby' }
      specify{ subject[:href].should eq tag_path tag }
    end
  end

  describe '#tags' do
    subject{ Capybara.string presenter.tags [tag] }
    it{ should have_selector 'li.tag', count:1 }
  end
end
