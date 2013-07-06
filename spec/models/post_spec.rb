require 'spec_helper'

describe Post do
   it { should validate_presence_of(:title) }
   it { should validate_uniqueness_of(:title) }

   it { should validate_presence_of(:text) }
end
