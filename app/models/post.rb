class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :text, presence: true

  belongs_to :user
  belongs_to :last_editor, class_name: "User", foreign_key: :last_editor_id

  def canEdit? (current_user = nil)
  	  self.can_modify || ( current_user and self.user == current_user )
  end

  def self.searchAll (key_word)
  	posts = self.basic_search(key_word)
  	posts += self.fuzzy_search(title: key_word)
  	posts += self.fuzzy_search(text: key_word)
  	posts.uniq
  end

end
