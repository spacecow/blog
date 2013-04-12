require 'spec_helper'

describe Section do
  context 'instance methods' do
    let(:section){ create :section }

    describe '#tag_tokens' do
      context 'one layer tag' do
        context 'tag exists' do
          let!(:tag){ create :tag, name:'ruby' }
          it{ lambda{ section.tag_tokens = tag.id.to_s }.should change(Tag,:count).by(0)}
          it{ lambda{ section.tag_tokens = '<<<ruby>>>' }.should change(Tag,:count).by(0) }

          context "last tag" do
            before{ section.tag_tokens = tag.id.to_s }
            subject{ Tag.last }
            its(:parent_id){ should be_nil }
            its(:section_ids){ should eq [Section.last.id] }
          end

          context "last section" do
            before{ section.tag_tokens = tag.id.to_s }
            subject{ section }
            its(:tag_ids){ should eq [Tag.last.id] }
          end
        end

        context 'tag has to be made' do
          it{ lambda{ section.tag_tokens = '<<<ruby>>>' }.should change(Tag,:count).by(1)}

          context "last tag" do
            before{ section.tag_tokens = '<<<ruby>>>' }
            subject{ Tag.last }
            its(:parent_id){ should be_nil }
            its(:section_ids){ should eq [Section.last.id] }
          end

          context "last section" do
            before{ section.tag_tokens = '<<<ruby>>>' }
            subject{ section }
            its(:tag_ids){ should eq [Tag.last.id] }
          end
        end
      end

      context 'two layer tag' do
        let(:programming){ Tag.find_by_name 'programming' }
        let(:ruby){ Tag.find_by_name 'ruby' }
        let(:last_section){ Section.last }

        it 'tag and parent has to be made' do
        end

        it 'tag exists, but parent is wrong' do
          create :tag, name:'ruby'
        end

        it 'parent exists' do
          create :tag, name:'programming'
        end

        it 'both exists, put tag points att wrong parent' do
          create :tag, name:'ruby'
          create :tag, name:'programming'
        end

        it 'both exists with corrent parent pointer' do
          
          create :tag, name:'programming'
          create :tag, name:'ruby', ancestry:Tag.first.id.to_s
        end

        after do
          section.tag_tokens = '<<<programming/ruby>>>'
          Tag.count.should be 2
          programming.name.should eq 'programming'
          programming.ancestry.should be_nil
          programming.section_ids.should be_empty
          ruby.name.should eq 'ruby'
          ruby.ancestry.should eq programming.id.to_s 
          ruby.section_ids.should eq [last_section.id]
        end
      end
    end
  end

  context 'class methods' do
    describe '.tag_counts' do
      let(:section1){ create :section }
      let(:tag1){ create :tag }
      before{ section1.tags << tag1 }

      it "one section, one tag" do
        tags = Section.tag_counts
        tags.to_a.count.should be 1 
        tags.to_a.first.count.should eq "1"
      end

      it "one section, two tags" do
        tag2 = create :tag
        section1.tags << tag2
        tags = Section.tag_counts
        tags.to_a.count.should be 2
        tags.to_a.first.count.should eq "1"
        tags.to_a.last.count.should eq "1"
      end

      it "two sections, one tag" do
        section2 = create :section
        section2.tags << tag1
        tags = Section.tag_counts
        tags.to_a.count.should be 1 
        tags.to_a.first.count.should eq "2"
      end
    end
  end
end
