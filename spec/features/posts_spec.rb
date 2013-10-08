require 'spec_helper'
require 'action_view/helpers/sanitize_helper'

class SanitizeHelper
  include ActionView::Helpers::SanitizeHelper
end

describe 'Posts' do
  let(:post) { FactoryGirl.create(:post) }
 
  context '#index' do
    let!(:comment){ FactoryGirl.create(:comment, post: post, rating: 3)}
    before { @post = post }

    context 'user not logged' do
      before { visit posts_path }

      it 'contain post title' do
        within("div.posts") do
           expect(page).to have_content post.title
        end
      end

      it 'contain first 200 letters of post text' do
        within("div.posts") do
          expect(page).to have_content SanitizeHelper.new.strip_tags(post.text).truncate(200, separator: ' ')
        end
      end

      it 'contain title links to post#show' do
        within("div.posts") do
          expect(page).to have_link post.title, post_path(post)
        end
      end

      it 'not contain delete link' do
        within("div.posts") do
          expect(page).not_to have_link "delete", post_path(post)
        end
      end

      it 'not contain edit link' do
        within("div.posts") do
          expect(page).not_to have_link "edit", edit_post_path(post)
        end
      end

      it 'contain comments count' do
        within("div.comments_count") do
          expect(page).to have_content "1"
        end
      end

      it 'contain average rating' do
        within("div.avg_rating") do
          expect(page).to have_selector ".show-rating i.icon-star"
        end
      end
    end

    context 'user logged' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
        visit posts_path
      end

      after(:each) { Warden.test_reset!  }

      it 'contain delete link' do
        within("div.posts .controls") do
          expect(page).to have_link "delete", post_path(post)
        end
      end

      it 'contain edit link' do
        within("div.posts .controls") do
          expect(page).to have_link "edit", edit_post_path(post)
        end
      end

    end
  end

  context '#new' do

    context 'user logged' do
      let(:user) { FactoryGirl.create(:user) }
      let!(:tag) { FactoryGirl.create(:tag) }

      before :each do
        login_as(user, :scope => :user)
        visit new_post_path
      end

      after(:each) { Warden.test_reset!  }

      it 'can create post' do
        expect do 
          within('form.post') do
            fill_in 'post_title', with: post.title
            fill_in 'post_text', with: post.text
            select(tag.name, :from => 'post_tag_ids')
            check 'post_private'
            click_on 'Create Post'
          end
        end.to change { Post.count }.by(1)
      end

      it 'can add pictures' do
        within('form.post') do
          expect(page).to have_selector('button#add-picture') 
        end
      end
    end

    context 'user not logged' do
      before { visit new_post_path }

      it 'gets redirected' do
        expect(page.current_path).to eq new_user_session_path
      end
    end
  end

  context "#show" do

    context 'user logged' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
        visit post_path(post)
      end

      after(:each) { Warden.test_reset!  }

      it 'contain delete link' do
        within('.post .controls') do
          expect(page).to have_link 'delete', post_path(post)
        end
      end

      it 'contain edit link' do
        within('.post .controls') do
          expect(page).to have_link 'edit', edit_post_path(post)
        end
      end
    end

    context 'user not logged' do
      let!(:comment){ FactoryGirl.create(:comment, post: post, rating: 3)}
      before { visit post_path(post)}

      it 'contain post title' do
        within('.post') do
          expect(page).to have_content post.title
        end
      end

      it 'contain post text' do
        within('.post') do
          expect(page).to have_content SanitizeHelper.new.strip_tags(post.text)
        end
      end

      it 'contain picture caption' do
        within('.post .pictures') do
          expect(page).to have_content post.pictures.first.caption
        end
      end

      it 'contain picture image' do
        expect(page).to have_css ('img[src*="' + post.pictures.first.image.url(:large) + '"]')
      end

      it 'contain creator name' do
        within('.post') do
          expect(page).to have_content post.user.name
        end
      end

      it 'contain created_at date' do
        within('.post') do
          expect(page).to have_content time_ago_in_words(post.created_at)
        end
      end

       it 'contain last editor name' do
        within('.post') do
          expect(page).to have_content post.last_editor.name
        end
      end

      it 'contain updated_at date' do
        within('.post') do
          expect(page).to have_content time_ago_in_words(post.updated_at)
        end
      end

      it 'not contain delete link' do
        within('.post') do
          expect(page).not_to have_link 'delete', post_path(post)
        end
      end

      it 'not contain edit link' do
        within('.post') do
          expect(page).not_to have_link 'edit', edit_post_path(post)
        end
      end

      
      it 'contain average rating' do
        within("div.avg_rating") do
          expect(page).to have_selector ".show-rating i.icon-star"
        end
      end

      context 'private posts' do
        
        let(:private_post) { FactoryGirl.build(:post, id: 1, private: true) }
        
        before do
          Post.stub(find: private_post)
          visit post_path(private_post)
        end

        it 'not contain post' do
          expect(page).not_to have_content private_post.text
        end

        it 'gets redirected' do
          expect(page.current_path).to eq new_user_session_path
        end
      end
    end
  end

  context "#destroy" do
    let!(:post) { FactoryGirl.create(:post) }
    
    context "user is logged" do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
      end

      after(:each) { Warden.test_reset!  }



      context "in show page" do
        before {visit post_path(post)}

        it 'can destroy post' do
          expect do
            within('.post .controls') do
              click_on 'delete'
            end
          end.to change { Post.count }.by(-1)
        end
      end

      context "in index page" do
        before { visit posts_path }

        it 'can destroy post' do
          expect do
            within('div.posts') do
              click_on 'delete'
            end
          end.to change { Post.count }.by(-1)
        end
      end

    end
  end

  context "#edit" do

    context "logged" do
      let(:user) { FactoryGirl.create(:user) }
      let(:post) { FactoryGirl.create(:post) }
      let!(:tag) { FactoryGirl.create(:tag) }
      

      before :each do
        login_as(user, :scope => :user)

        visit edit_post_path(post)

        within("form.post") do
          fill_in 'post_title', with: "New Title"
          fill_in 'post_text', with: 'New Body text'
          select(tag.name, :from => 'post_tag_ids')
          check 'post_private'

          click_on 'Update Post'
        end
      end

      after(:each) { Warden.test_reset! }

      it 'title is changed' do
        expect(page).to have_content "New Title"
      end

      it 'text is changed' do
        expect(page).to have_content "New Body text"
      end

      it 'tags is changed' do
        within '.post .tags' do
          expect(page).to have_content tag.name
        end
      end

      it 'private is changed' do
        expect(page).to have_selector ".private", text: 'private'
      end

    end

    context 'not logged' do
      it 'gets redirected' do
        visit edit_post_path(post)
        expect(page.current_path).to eq new_user_session_path
      end
    end

  end

  describe "unalterable posts" do
    let!(:post) { FactoryGirl.create(:post, can_modify: false) }
    
    context 'user is logged' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
      end

      after(:each) { Warden.test_reset!  }

      context "logget user is post's author" do
        before { post.update_attributes(:user => user) }
        
        context '#index' do
          before :each do
            visit posts_path
          end

          it 'contain delete link' do
            within("div.posts .controls") do
              expect(page).to have_link "delete", post_path(post)
            end
          end

          it 'contain edit link' do
            within("div.posts .controls") do
              expect(page).to have_link "edit", edit_post_path(post)
            end
          end
        end

        context "#show" do
          before do
            visit post_path(post) 
          end

          it 'contain delete link' do
            within(".post") do
              expect(page).to have_link "delete", post_path(post)
            end
          end

          it 'contain edit link' do
            within(".post") do
              expect(page).to have_link "edit", edit_post_path(post)
            end
          end
        end
      end

      context "logget user is not post's author" do
        before { post.update_attributes(:user => FactoryGirl.build(:user)) }

        context '#index' do
          before :each do
            visit posts_path
          end

          it 'not contain delete link' do
            within("div.posts") do
              expect(page).not_to have_link "delete", post_path(post)
            end
          end

          it 'not contain edit link' do
            within("div.posts") do
              expect(page).not_to have_link "edit", edit_post_path(post)
            end
          end
        end

        context "#show" do
          before do
            visit post_path(post) 
          end

          it 'not contain delete link' do
            within(".post") do
              expect(page).not_to have_link "delete", post_path(post)
            end
          end

          it 'not contain edit link' do
            within(".post") do
              expect(page).not_to have_link "edit", edit_post_path(post)
            end
          end
        end
      end
    end
  end

  describe "pagination" do
    let!(:posts) { FactoryGirl.create_list(:post, 11) }

    describe "in index page" do
      before { visit root_path }

      it "contain link to next page" do
        expect(page).to have_link "Next ›", "/posts?page=2" 
      end

      it "contain link to 2nd page" do
        expect(page).to have_link "2", "/posts?page=2" 
      end
    end 
  end
end