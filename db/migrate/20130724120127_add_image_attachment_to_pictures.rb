class AddImageAttachmentToPictures < ActiveRecord::Migration
  def change
  	add_attachment :pictures, :image
  end
end
