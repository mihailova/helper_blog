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
      before { visit new_post_path }

      it 'gets redirected' do
        expect(page.current_path).to eq new_user_session_path
      end
    end
  end

  context "#show" do

    before do
      Post.stub(find: post)
    end
    context 'user logged' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
        visit post_path(post)
      end

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
      before { visit post_path(post)}

      it 'content post title' do
        within('.post') do
          expect(page).to have_content post.title
        end
      end

      it 'content post text' do
        within('.post') do
          expect(page).to have_content post.text
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

end