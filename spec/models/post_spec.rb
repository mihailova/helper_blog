require 'spec_helper'

describe Post do
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:user_id) }
	it { should validate_uniqueness_of(:title) }

	it { should validate_presence_of(:text) }
	it { should belong_to(:user) }
	it { should belong_to(:last_editor).class_name('User') }
	it { should have_many(:comments).dependent(:destroy) }

	it { should have_many(:pictures).dependent(:destroy) }
	it { should have_and_belong_to_many(:tags) }

	it { should accept_nested_attributes_for(:pictures).
              allow_destroy(true)}

	describe "searchALL" do
		let(:post) { FactoryGirl.create(:post, title: "Some title")}
		let(:tag) { FactoryGirl.create(:tag, name: "Tag_name")}
		
		it "can search posts by keyword" do
			expect([post]).to eq Post.searchAll("Some")
		end

		it "can search posts by tag keyword" do
			post.tags << tag
			post.save
			expect([post]).to eq Post.searchAll("Tag_n")
		end
	end

	describe "filter" do
		context "by tags" do 
			let(:post_1) { FactoryGirl.create(:post)}
			let(:tag) {FactoryGirl.create(:tag)}
			let!(:post_2) { FactoryGirl.create(:post)}

			before do
				post_1.tags << tag
				post_1.save
			end

			it "filter post by tag" do 
				expect([post_1]).to eq Post.filter({tags: [tag.id.to_s]})
			end 
		end

		context "by authors" do 
			let(:user_1) { FactoryGirl.create(:user)}
			let(:user_2) { FactoryGirl.create(:user)}
			let!(:post_2) { FactoryGirl.create(:post, user: user_2)}
			let(:post_1) { FactoryGirl.create(:post, user: user_1)}

			it "filter post by authors" do 
				expect([post_1]).to eq Post.filter({authors: [user_1.id.to_s]})
			end
		end

		context "by private" do 
			let!(:post) { FactoryGirl.create(:post)}
			let(:private_post) { FactoryGirl.create(:post, private: true)}

			it "filter by private" do
				expect([private_post]).to eq Post.filter({private: "1"})
			end
		end
	end

	describe "Sort_by" do
		context "title" do 
			let(:post_last) { FactoryGirl.create(:post, title: "B")}
			let(:post_first) { FactoryGirl.create(:post, title: "A")}

			it "sort by title" do
				expect([post_first, post_last]).to eq Post.sort_by('title')
			end
		end

		context "comments count" do 
			let(:post_last) { FactoryGirl.create(:post)}
			let(:comment) { FactoryGirl.create(:comment)}

			it "sort by comments count" do
				expect([comment.post, post_last]).to eq Post.sort_by('comments')
			end
		end

		context "rating" do 
			let(:comment_last) { FactoryGirl.create(:comment, rating: 2)}
			let(:comment_first) { FactoryGirl.create(:comment, rating: 5)}

			it "sort by avg rating" do
				expect([comment_first.post, comment_last.post]).to eq Post.sort_by('rating')
			end
		end

		context "author" do 
			let(:user_first) { FactoryGirl.create(:user, name: "A")}
			let(:user_last) { FactoryGirl.create(:user, name: "B")}
			let(:post_last) { FactoryGirl.create(:post, user: user_last)}
			let(:post_first) { FactoryGirl.create(:post, user: user_first)}

			it "sort by author's name" do
				expect([post_first, post_last]).to eq Post.sort_by('author')
			end
		end
	end
end
