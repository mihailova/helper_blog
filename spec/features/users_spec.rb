require 'spec_helper'

describe 'Users' do
  describe 'links' do

    context 'not logged' do

      it 'sign in' do
        visit root_path

        within '.navbar' do
          expect(page).to have_link 'Login', new_user_session_path
        end
      end
    end

    context 'logged' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
      end

      after(:each) { Warden.test_reset!  }

      it 'sign out' do
        visit root_path

        within '.navbar' do
          expect(page).to have_link 'Logout', destroy_user_session_path
        end
      end
    end

  end
end