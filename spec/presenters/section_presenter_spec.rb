require 'spec_helper'

describe SectionPresenter do
  let(:section){ stub_model Section }
  let(:presenter){ SectionPresenter.new(section,view) }

  describe '#content' do
    subject{ Capybara.string presenter.content }
    before{ section.should_receive(:content).and_return 'some other content' }
    its(:text){ should match /some other content/ }
  end

  describe '#sections' do
    subject{ Capybara.string presenter.sections [section] }
    it{ should have_selector 'div.section.hover', count:1 }
  end
end
