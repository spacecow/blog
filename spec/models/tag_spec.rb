require 'spec_helper'

describe Tag do
  it 'name cannot be blank' do
    expect{ create :tag, name:'' }.to raise_error *blank_error 
  end

  it 'name cannot be duplicated' do
    create :tag, name:'ruby'
    expect{ create :tag, name:'ruby' }.to raise_error *duplication_error 
  end

  describe '#leaf_name' do
    let(:tag){ stub_model Tag }
    it 'name is nil, leaf name is nil' do
      tag.leaf_name.should be_nil 
    end

    it 'non-nested name returns the name' do
      tag.should_receive(:name).and_return 'ruby'
      tag.leaf_name.should eq 'ruby'
    end

    it 'nested name returns the leaf name' do
      tag.should_receive(:name).and_return 'programming/ruby'
      tag.leaf_name.should eq 'ruby'
    end
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

  describe '#leaf_name=' do
    let(:tag){ mock_model Tag }
  end
end
