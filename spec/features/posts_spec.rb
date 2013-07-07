require 'spec_helper'

describe 'Posts' do

  context '#index' do
    let(:post) { FactoryGirl.build(:post, id: 10) }

    before :each do
      Post.stub(all: [post]) 
    end

    context 'user not logged' do
      before { visit posts_path }

      it 'contain post title' do
        within("div.posts") do
           expect(page).to have_content post.title
        end
      end

      it 'contain first 200 letters of post text' do
        within("div.posts") do
          expect(page).to have_content post.text.truncate(200, separator: ' ')
        end
      end

      it 'title links to post#show' do
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
end