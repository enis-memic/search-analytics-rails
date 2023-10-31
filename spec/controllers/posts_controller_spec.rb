require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "GET #index" do
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end
    end
  
    describe "GET #show" do
      it "returns a success response" do
        post = Post.create(title: "Test Post", body: "This is a test post")
        get :show, params: { id: post.to_param }
        expect(response).to be_successful
      end
    end
  
    describe "GET #new" do
      it "returns a success response" do
        get :new
        expect(response).to be_successful
      end
    end
    
    describe "GET #edit" do
    it "returns a success response" do
      post = Post.create(title: "Title", body: "Content")
      get :edit, params: { id: post.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    let(:post) { Post.create(title: "Title", body: "Content") }

    context "with valid attributes" do
      it "updates the post" do
        patch :update, params: { id: post.id, post: { title: "Updated Title" } }
        post.reload
        expect(post.title).to eq("Updated Title")
      end

      it "redirects to the updated post" do
        patch :update, params: { id: post.id, post: { title: "Updated Title" } }
        expect(response).to redirect_to(post)
      end
    end

    context "with invalid attributes" do
      it "does not update the post" do
        patch :update, params: { id: post.id, post: { title: nil } }
        post.reload
        expect(post.title).to eq("Title")
      end

      it "re-renders the edit method" do
        patch :update, params: { id: post.id, post: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:post) { Post.create(title: "Title", body: "Content") }

    it "destroys the requested post" do
      expect {
        delete :destroy, params: { id: post.id }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to(posts_url)
    end
  end
end
  