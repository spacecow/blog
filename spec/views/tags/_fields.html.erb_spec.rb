require 'spec_helper'

describe 'tags/_fields.html.erb' do
  context 'edit tag' do
    let!(:ruby){ create :tag }
    let(:rendering){ Capybara.string rendered }

    context "no nesting" do
      before do
        ruby.name = 'ruby'
        view.simple_form_for(ruby){|f| @f=f}
        render 'tags/fields', f:@f 
      end

      it "name is displayed as it is" do
        rendering.find_field('Name').value.should eq 'ruby'
      end

      it "parent selection does not list itself" do
        rendering.find_field('Parent').all('option').map(&:text).should eq ['']
      end

      it "no parent is selected" do
        rendering.find_field('Parent').all('option[selected]').count.should eq 0
      end
    end

    context "nesting" do
      before do
        language = create :tag, name:'language'
        ruby.name = 'ruby'
        ruby.parent = language
        render 'tags/form', tag:ruby
      end

      it "name just displays the leaf value" do
        rendering.find_field('Name').value.should eq 'ruby'
      end

      it "parent selection lists all tags execept itself" do
        rendering.find_field('Parent').all('option').map(&:text).should eq ['', 'language']
      end

      it "parent is selected" do
        rendering.find_field('Parent').find('option[selected]').text.should eq 'language'
      end
    end
  end
end

