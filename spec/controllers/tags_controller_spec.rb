require 'spec_helper'

describe TagsController do
  context 'update a tag' do
    let(:tag){ mock_model Tag }
    before{ Tag.should_receive(:find).and_return tag }
    context 'saves to db' do
      before do
        tag.should_receive(:update_attributes).and_return true
        put :update, id:1
      end

      context 'response' do
        subject{ response }
        it{ should redirect_to tag }
      end

      context 'flash' do
        subject{ flash }
        its(:notice){ should eq 'Tag updated' }
      end
    end

    context 'error' do
      before do
        tag.should_receive(:update_attributes).and_return false
        put :update, id:1
      end
      subject{ response }
      it{ should render_template :edit }
    end
  end

  context 'delete a tag' do
    context 'deletes from database' do
      let!(:tag){ create :tag }
      before{ tag.sections << create(:section) }

      it{ lambda{ delete :destroy, id:tag.id }.should change(Tag,:count).by(-1) }
      it{ lambda{ delete :destroy, id:tag.id }.should change(Tagging,:count).by(-1) }

      context 'response' do
        before{ delete :destroy, id:tag.id }
        subject{ response }
        it{ should redirect_to tags_path }
      end

      context 'flash' do
        before{ delete :destroy, id:tag.id }
        subject{ flash }
        its(:notice){ should eq 'Tag deleted' }
      end
    end
  end
end
