class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :text, presence: true

  belongs_to :user

end
