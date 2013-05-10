require 'spec_helper'

describe Tag do
  it 'name cannot be blank' do
    lambda{ create :tag, name:'' }.should raise_error ActiveRecord::RecordInvalid, 'Validation failed: Name can\'t be blank'
  end

  it 'name cannot be duplicated' do
    create :tag, name:'ruby'
    lambda{ create :tag, name:'ruby' }.should raise_error ActiveRecord::RecordInvalid, 'Validation failed: Name has already been taken'
  end

  describe '.pop_tag' do
    it{ Tag.send('pop_tag','ruby').should eq [nil,'ruby'] }
    it{ Tag.send('pop_tag','programming/ruby').should eq ['programming','ruby'] }
    it{ Tag.send('pop_tag','life/programming/ruby').should eq ['life/programming','ruby'] }
  end

  describe '#branch' do
    let(:tag){ stub_model Tag }
    it 'no parent, returns self' do
      tag.should_receive(:ancestors).and_return []
      tag.branch.should eq [tag]
    end 
    it 'parent, returns self and parent' do
      parent = mock_model Tag
      tag.should_receive(:ancestors).and_return [parent] 
      tag.branch.should eq [parent,tag]
    end
  end
end
