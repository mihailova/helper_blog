require 'spec_helper'

describe ApplicationHelper do
 
   describe "comments_form_url" do
    let(:post){ FactoryGirl.create(:post) }
    context "New record" do
      let(:comment) {FactoryGirl.build(:post, id: 1)}
      its "resturn url for new record" do
        helper.comments_form_url(post, comment).should eq "/posts/#{post.id}/comments"
      end
    end
    context "Old record" do
      let(:comment) {FactoryGirl.create(:post)}
      its "resturn url for old record" do
        helper.comments_form_url(post, comment).should eq "/posts/#{post.id}/comments/#{comment.id}"
      end
    end
  end

  describe "comments_form_class" do
    context "New record" do
      let(:comment) {FactoryGirl.build(:post, id: 1)}
      its "resturn class for new record" do
        helper.comments_form_class(comment).should eq ""
      end
    end
    context "Old record" do
      let(:comment) {FactoryGirl.create(:post)}
      its "resturn class for old record" do
        helper.comments_form_class(comment).should eq "well"
      end
    end
  end
end