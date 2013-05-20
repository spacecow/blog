require 'spec_helper'

describe TagPresenter do
  let(:tag){ stub_model Tag, name:'ruby' }
  let(:presenter){ TagPresenter.new tag,view }
  let(:rendering){ Capybara.string function }

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
    let(:perl){ create :tag, name:'perl' }
    subject{ Capybara.string presenter.tags [tag,perl] }
    it{ should have_selector 'li.tag.title', count:2 }
    its(:text){ should eq 'ruby, perl' }
  end

  describe '#form' do
    let(:function){ presenter.form }
    it "renders the form" do
      rendering.find('form')
    end
  end
end
