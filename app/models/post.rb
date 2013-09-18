class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :text, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :last_editor, class_name: "User", foreign_key: :last_editor_id
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  has_many :pictures, dependent: :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true

  scope :sort_by, ->(sort_query = nil) do 
    if sort_query == "title"
      order("title ASC")
    elsif sort_query == "rating"
      where("posts.id in (select post_id from comments)").group('posts.id').joins(:comments).order('AVG(comments.rating) DESC') + 
      includes(:comments).where("comments.id is NULL")
    elsif sort_query == "author"
      joins(:user).order('users.name ASC')
    else
      all
    end
    end

  def canEdit? (current_user = nil)
  	  self.can_modify || ( current_user and self.user == current_user )
  end

  def rating
    self.comments.average(:rating).to_i
  end

  def self.searchAll (key_word)
  	posts = self.basic_search(key_word)
  	posts += self.fuzzy_search(title: key_word)
  	posts += self.fuzzy_search(text: key_word)
    posts += self.includes(:tags).where(["tags.name ILIKE ?", "%#{key_word}%"])
  	posts.uniq
  end
end
