require 'spec_helper'

describe CommentsController do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in user
  end

  after(:each) { sign_out user  }
  let(:valid_attributes) { {text: "Some text"} }
  let!(:comment) { FactoryGirl.create(:comment, user: user) }
  
  describe "GET edit" do
    it "assigns the requested comment as @comment" do
      xhr :get, :edit, {:id => comment.to_param, post_id: comment.post.id}
      assigns(:comment).should eq(comment)
    end
  end

  describe "POST create" do
    it "creates a new Comment" do
      expect {
       xhr :post, :create, {:comment => valid_attributes, post_id: comment.post.id}
      }.to change(Comment, :count).by(1)
    end

    it "assigns a newly created comment as @comment" do
      xhr :post, :create, {:comment => valid_attributes, post_id: comment.post.id}
      assigns(:comment).should be_a(Comment)
      assigns(:comment).should be_persisted
    end
  end

  describe "PUT update" do
   
    it "updates the requested comment" do
      Comment.any_instance.should_receive(:update).with({"post_id"=>comment.post.id, "user_id"=>comment.user.id})
      xhr :put, :update, {:id => comment.to_param, :comment => { "these" => "params" }, post_id: comment.post.id}
    end

    it "assigns the requested comment as @comment" do
      xhr :put, :update, {:id => comment.to_param, :comment => valid_attributes, post_id: comment.post.id}
      assigns(:comment).should eq(comment)
    end
  end

  describe "DELETE destroy" do
    
    it "destroys the requested comment" do
      expect {
       xhr :delete, :destroy, {:id => comment.to_param, post_id: comment.post.id}, format: :js
      }.to change(Comment, :count).by(-1)
    end
  end
end
