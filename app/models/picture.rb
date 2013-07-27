class Picture < ActiveRecord::Base
  belongs_to :post

  has_attached_file :image, 
    :styles => { :medium => "300x300>", :thumb => "100x100>", large: "600x600" }
end
