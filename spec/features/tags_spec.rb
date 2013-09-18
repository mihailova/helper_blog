require 'spec_helper'

describe 'Tags' do
  let!(:tag) { FactoryGirl.create(:tag) }
 
  context '#index' do

    context 'user not logged' do
      before { visit tags_path }

      it 'contain tag name' do
        within("div.tags") do
           expect(page).to have_content tag.name
        end
      end

      it 'contain title links to tags#show' do
        within("div.tags") do
          expect(page).to have_link tag.name, tag_path(tag)
        end
      end

      it 'not contain delete link' do
        within("div.tags") do
          expect(page).not_to have_link "delete", tag_path(tag)
        end
      end

      it 'not contain edit link' do
        within("div.tags") do
          expect(page).not_to have_link "edit", edit_tag_path(tag)
        end
      end

      it 'not contain New link' do
        expect(page).not_to have_link "New Tag", new_tag_path
      end
    end

    context 'user logged' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
        visit tags_path
      end

      after(:each) { Warden.test_reset!  }

      it 'contain delete link' do
        within("div.tags .controls") do
          expect(page).to have_link "delete", tag_path(tag)
        end
      end

      it 'contain edit link' do
        within("div.tags .controls") do
          expect(page).to have_link "edit", edit_tag_path(tag)
        end
      end

      it "contain 'New Tag' link" do
        expect(page).to have_link "New Tag", new_tag_path
      end
    end
  end

  context '#new' do

    context 'user logged' do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
        visit new_tag_path
      end

      after(:each) { Warden.test_reset!  }

      it 'can create tag' do
        expect do 
          within('form.tag') do
            fill_in 'tag_name', with: "Some name"
            click_on 'Create Tag'
          end
        end.to change { Tag.count }.by(1)
      end
    end

    context 'user not logged' do
      before { visit new_tag_path }

      it 'gets redirected' do
        expect(page.current_path).to eq new_user_session_path
      end
    end
  end

  context "#show" do
    let(:post) { FactoryGirl.create(:post) } 

    before do
      tag.posts << post
      tag.save
      visit tag_path(tag)
    end

    it "contain tag's post name" do
      expect(page).to have_content post.title
    end

    it "contain link to tag's post" do
      expect(page).to have_link post.title, post_path(post)
    end
  end

  context "#destroy" do
    
    context "user is logged" do
      let(:user) { FactoryGirl.create(:user) }

      before :each do
        login_as(user, :scope => :user)
        visit tags_path
      end

      after(:each) { Warden.test_reset!  }

      it 'can destroy tag' do
        expect do
          within('div.tags .controls') do
            click_on 'delete'
          end
        end.to change { Tag.count }.by(-1)
      end
    end
  end

  context "#edit" do

    context "logged" do
      let(:user) { FactoryGirl.create(:user) }
      
      before :each do
        login_as(user, :scope => :user)

        visit edit_tag_path(tag)

        within("form.tag") do
          fill_in 'tag_name', with: "New Name"
          click_on 'Update Tag'
        end
      end

      after(:each) { Warden.test_reset! }

      it 'name is changed' do
        tag.reload
        expect(tag.name).to eq "New Name"
      end

      it 'redirect to tags_path' do
        expect(page.current_path).to eq tags_path
      end
    end

    context 'not logged' do
      it 'gets redirected' do
        visit edit_tag_path(tag)
        expect(page.current_path).to eq new_user_session_path
      end
    end
  end

  describe "pagination" do
    let!(:tags) { FactoryGirl.create_list(:tag, 11) }

    describe "in index page" do
      before { visit tags_path }

      it "contain link to next page" do
        expect(page).to have_link "Next ›", "/tags?page=2" 
      end

      it "contain link to 2nd page" do
        expect(page).to have_link "2", "/tags?page=2" 
      end
    end 
  end
end