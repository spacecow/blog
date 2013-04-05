require 'spec_helper'

describe SectionPresenter do
  let(:section){ mock_model Section }
  let(:presenter){ SectionPresenter.new(section,view) }
  subject{ rendered }

  describe '#content' do
    let(:rendered){ Capybara.string presenter.content }
    before{ section.should_receive(:content).and_return 'some other content' }
    its(:text){ should match /some other content/ }
  end

  describe '#sections' do
    let(:rendered){ Capybara.string presenter.sections [section] }
    it{ should have_selector 'div.section' }
  end
end
