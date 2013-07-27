class PicturesController < ApplicationController
  def destroy
  	@picture = Picture.find(params[:id])
    @picture.destroy
    respond_to do |format|
      format.js
    end
  end
end
