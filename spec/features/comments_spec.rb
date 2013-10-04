require 'spec_helper'

describe 'Comments' do
  let(:user) { FactoryGirl.create(:user) }
  let(:comment) {FactoryGirl.create(:comment)}

  context "logged user" do
    before :each do
      login_as(user, :scope => :user)
      visit post_path(comment.post)
    end

    after(:each) { Warden.test_reset!  }

    it "contain create comment form" do
      within (".comment-form") do
        expect(page).to have_selector ("#comment_text")
      end
    end

    context "comment author" do
      before do
        comment.update(user: user)
        visit post_path(comment.post)
      end

      it "can delete it's own comments" do
        within ("#comments .comment") do
          expect(page).to have_link 'delete', post_comment_path(comment.post, comment)
        end
      end

      it "can edit it's own comments" do
        within ("#comments .comment") do
          expect(page).to have_link 'edit', edit_post_comment_path(comment.post, comment)
        end
      end
    end

    context "not comment author" do
      before do
        comment.update(user: FactoryGirl.create(:user))
        visit post_path(comment.post)
      end

      it "can't delete other user's comments" do
        within ("#comments .comment") do
          expect(page).not_to have_link 'delete', post_comment_path(comment.post, comment)
        end
      end


      it "can't edit other user's comments" do
        within ("#comments .comment") do
          expect(page).not_to have_link 'edit', edit_post_comment_path(comment.post, comment)
        end
      end
    end
  end

  context "not logged user" do
    before {visit post_path(comment.post)}

    it "contain create comment form" do
      expect(page).to have_selector(".comment-form")
    end

    it "contain post's comments" do
      expect(page).to have_content comment.text
    end

    it "contain post's comments authors" do
      expect(page).to have_content comment.user.name
    end

    it "contain post's comments created at date" do
      expect(page).to have_content time_ago_in_words(comment.created_at)
    end
  end
end