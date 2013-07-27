require 'spec_helper'

describe User do
	it { should have_many(:posts) }
	it { should have_many(:changed_posts).class_name('Post') }
  it { should have_many(:comments).dependent(:destroy) }
	
end
