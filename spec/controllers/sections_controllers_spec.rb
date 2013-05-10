require 'spec_helper'

describe SectionsController do
  context 'create a post' do
    let!(:section){ build :section }
    before{ Section.should_receive(:new).and_return section }

    context 'saves to db' do
      before{ post :create, section:{content:'yeah'} }

      context 'response' do
        subject{ response }
        it{ should redirect_to section }
      end

      context 'flash' do
        subject{ flash }
        its(:notice){ should eq 'Section created' }
      end
    end

    context 'error' do
      before do
        section.should_receive(:save).and_return false
        post :create, section:{content:'yeah'}
      end
      subject{ response }
      it{ should render_template :new }
    end
  end

  context 'update a post' do
    let(:section){ mock_model Section }
    before{ Section.should_receive(:find).and_return section }

    context 'saves to db' do
      before do
        section.should_receive(:update_attributes).and_return true
        put :update, id:1, section:{content:'yeah'}
      end
      
      context 'response' do
        subject{ response }
        it{ should redirect_to section }
      end

      context 'flash' do
        subject{ flash }
        its(:notice){ should eq 'Section updated' }
      end
    end

    context 'error' do
      before do
        section.should_receive(:update_attributes).and_return false
        put :update, id:1, section:{content:'yeah'}
      end
      subject{ response }
      it{ should render_template :edit }
    end
  end
end 
