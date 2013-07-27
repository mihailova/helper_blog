class Picture < ActiveRecord::Base
  belongs_to :post

  has_attached_file :image, 
    :styles => { :medium => "350x350>", :thumb => "100x100>", large: "1000x1000" }
end
