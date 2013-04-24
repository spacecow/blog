require 'spec_helper'

describe SectionPresenter do
  let(:section){ stub_model Section }
  let(:presenter){ SectionPresenter.new(section,view) }

  describe '#content' do
    context "" do
      before{ section.should_receive(:content).and_return 'some other content' }
      subject{ Capybara.string presenter.content }
      its(:text){ should match /some other content/ }
    end

    context "link to other section" do
      before do
        create :section, id:1, content:'yeah'
        section.should_receive(:content).and_return "some other content\n->1"
      end
      subject{ Capybara.string presenter.content }
      its(:text){ should match /some other content.*yeah/m }
    end
  end

  describe '#post' do
    let(:rendering){ Capybara.string presenter.post }
    context 'post does not exist' do
      before do
        section.should_receive(:post).and_return nil
      end
      subject{ rendering } 
      its(:text){ should be_blank } 
    end

    context 'post exists' do
      before do
        ruby = create :post
        section.should_receive(:post).and_return ruby
        ruby.should_receive(:title).and_return 'Ruby'
      end
      subject{ rendering } 
      its(:text){ should eq 'Ruby' } 

      context 'link' do
        subject{ rendering.find 'a' }
        its(:text){ should eq 'Ruby' }
      end
    end
  end

  describe '#sections' do
    subject{ Capybara.string presenter.sections [section] }
    it{ should have_selector 'div.section.hover', count:1 }
  end
end
