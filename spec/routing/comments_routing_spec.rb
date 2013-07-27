require "spec_helper"

describe CommentsController do
  describe "routing" do
    let(:post) { FactoryGirl.create(:post) }
   

    it "routes to #edit" do
      get("/posts/1/comments/1/edit").should route_to("comments#edit", :id => "1", post_id: "1")
    end

    xit "routes to #create" do
      post("/posts/1/comments").should route_to("comments#create")
    end

    it "routes to #update" do
      put("/posts/1/comments/1").should route_to("comments#update", :id => "1", post_id: "1")
    end

    it "routes to #destroy" do
      delete("/posts/1/comments/1").should route_to("comments#destroy", :id => "1", post_id: "1")
    end

  end
end
