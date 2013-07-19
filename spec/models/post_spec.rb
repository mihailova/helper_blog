require 'spec_helper'

describe Post do
   it { should validate_presence_of(:title) }
   it { should validate_uniqueness_of(:title) }

   it { should validate_presence_of(:text) }
   it { should belong_to(:user) }
   it { should belong_to(:last_editor).class_name('User') }
end
