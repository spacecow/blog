require 'spec_helper'

describe TagsController do
  context 'create a tag' do
    let!(:tag){ build :tag }
    before{ Tag.should_receive(:new).and_return tag }

    context 'saves to db' do
      before{ post :create, tag:{id:1} }

      specify{ response.should redirect_to tag }
      specify{ flash.notice.should eq 'Tag created' }
    end

    context 'error' do
      before do
        tag.should_receive(:save).and_return false 
        post :create, tag:{id:1}
      end
      specify{ response.should render_template :new }
    end
  end

  context 'update a tag' do
    let(:tag){ mock_model Tag }
    before{ Tag.should_receive(:find).and_return tag }
    context 'saves to db' do
      before do
        tag.should_receive(:update).and_return true
        put :update, id:1, tag:{id:1}
      end

      specify{ response.should redirect_to tag }
      specify{ flash.notice.should eq 'Tag updated' }
    end

    context 'error' do
      before do
        tag.should_receive(:update).and_return false
        put :update, id:1, tag:{id:1}
      end
      specify{ response.should render_template :edit }
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
        specify{ response.should redirect_to tags_path }
      end

      context 'flash' do
        before{ delete :destroy, id:tag.id }
        specify{ flash.notice.should eq 'Tag deleted' }
      end
    end
  end
end
