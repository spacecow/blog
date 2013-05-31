require 'spec_helper'

describe TagPresenter do
  let(:tag){ stub_model Tag, name:'ruby' }
  let(:presenter){ TagPresenter.new tag,view }
  let(:rendering){ Capybara.string function }
  subject{ rendering }

  describe '#branch' do
    let(:function){ presenter.branch }
    before{ tag.should_receive(:branch).and_return [tag] }
    its(:text){ should eq 'ruby' } 

    describe 'link' do
      subject{ rendering.find('a') }
      its(:text){ should eq 'ruby' }
      specify{ subject[:href].should eq tag_path tag }
    end
  end

  describe '#tags' do
    let(:perl){ create :tag, name:'perl' }
    let(:function){ presenter.tags [tag,perl] }
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
