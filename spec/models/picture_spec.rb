require 'spec_helper'

describe Picture do
  it { should belong_to(:post) }
  it { should have_attached_file(:image) }
end
