require 'spec_helper'

describe Section do
  describe '#tag_tokens' do
    let(:tag){ create :tag }
    let(:section){ stub_model Section }
    before do
      section.tag_tokens = tag.id.to_s 
    end 

    subject{ section }
    its(:tag_ids){ should eq [tag.id] }
  end
end
