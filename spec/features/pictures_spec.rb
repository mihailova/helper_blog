require 'spec_helper'

describe 'Pictures' do
  let(:post) { FactoryGirl.create(:post) }

  describe '#destroy' do
    context 'user logged' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
        visit edit_post_path(post)
      end

      after(:each) { Warden.test_reset!  }

      it 'content delete picture link' do
        within ('.post .picture') do
          expect(page).to have_link "delete", picture_path(post.pictures.first)
        end
      end
    end
  end
end


