require 'spec_helper'

describe PostsController do
  let(:last_post){ Post.last }
  let(:last_section){ Section.last }

  context "create a post" do
    let(:create_post){ post :create, post:{title:'some title', sections_attributes:{'0' => {content:'some content'}}}}

    it{ lambda{ create_post }.should change(Post,:count).by(1) }
    it{ lambda{ create_post }.should change(Section,:count).by(1) }

    context "saves to db" do
      before{ create_post }

      context "last post" do
        subject{ last_post }
        its(:title){ should eq 'some title' }
      end

      context "last section" do
        subject{ last_section }
        its(:content){ should eq 'some content' }
        its(:post_id){ should be last_post.id }
      end

      context "response" do
        subject{ response }
        it{ should redirect_to last_post } 
      end

      context "flash" do
        subject{ flash }
        its(:notice){ should eq 'Post created' }
      end
    end

    context 'error' do
      let(:new_post){ mock_model(Post).as_new_record }
      before do
        Post.should_receive(:new).and_return new_post
        new_post.should_receive(:save).and_return false
        create_post
      end
      subject{ response }
      it{ should render_template :new }
    end
  end

  context "update a post" do
    let!(:_post){ create :post }
    let(:update_post){ put :update, id:1, post:{title:'yey'} }
    
    context "saves to db" do
      before do
        Post.should_receive(:find).and_return _post
        _post.should_receive(:update_attributes).and_return true
        update_post
      end

      context "response" do
        subject{ response }
        it{ should redirect_to last_post } 
      end

      context "flash" do
        subject{ flash }
        its(:notice){ should eq 'Post updated' }
      end
    end

    context 'error' do
      before do
        Post.should_receive(:find).and_return _post
        _post.should_receive(:update_attributes).and_return false
        update_post
      end
      subject{ response }
      it{ should render_template :edit }
    end
  end
end
