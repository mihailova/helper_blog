class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :text, presence: true

  belongs_to :user
  belongs_to :last_editor, class_name: "User", foreign_key: :last_editor_id

  def canEdit? (current_user = nil)
  	  self.can_modify || ( current_user and self.user == current_user )
  end

end
