require 'spec_helper'

describe 'Posts' do
  let(:post) { FactoryGirl.build(:post, id: 10) }

  context '#index' do
    
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

  context '#new' do

    context 'user logged' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
        visit new_post_path
      end

      after(:each) { Warden.test_reset!  }

      it 'can create post' do
        expect do 
          within('form') do
            fill_in 'post_title', with: post.title
            fill_in 'post_text', with: post.text
            fill_in 'post_tags', with: 'new'
            check 'post_private'

            click_on 'Create Post'
          end
        end.to change { Post.count }.by(1)
      end
    end

    context 'user not logged' do
    end
  end

end