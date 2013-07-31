require 'spec_helper'

describe PicturesController do

  describe "DELETE 'destroy'" do
    let!(:picture) {FactoryGirl.create(:picture)}
    it "delete picture" do
      expect do
        xhr :delete, :destroy, {:id => picture.id}
      end.to change(Picture, :count).by(-1)
    end
  end

end
