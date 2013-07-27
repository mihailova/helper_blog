require 'spec_helper'

describe PicturesController do

  describe "DELETE 'destroy'" do
    let!(:post) {FactoryGirl.create(:post)}
    it "returns http success" do
      xhr :delete, :destroy, {:id => post.pictures.first.id}
            response.should be_success
    end
  end

end
