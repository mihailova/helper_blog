require 'spec_helper'

describe 'Posts' do

  context '#index' do
    let(:post) { FactoryGirl.build(:post) }

    before :each do
      Post.stub(all: [post]) 

      visit posts_path
    end

   

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



  end


end