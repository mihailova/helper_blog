require 'spec_helper'

describe Post do
	it { should validate_presence_of(:title) }
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
end
