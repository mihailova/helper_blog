class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :text, presence: true
  validates :user_id, presence: true
  
  before_save :set_tags_ids

  belongs_to :user
  belongs_to :last_editor, class_name: "User", foreign_key: :last_editor_id
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  has_many :pictures, dependent: :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy => true

  scope :sort_by, ->(sort_query = nil) do 
    #TODO: refactoring 
    if sort_query == "title"
      order("title ASC")
    elsif sort_query == "rating"
      order("avg_rating DESC")
    elsif sort_query == 'comments'
      order("comments_count DESC")
    elsif sort_query == "author"
      joins(:user).order('users.name ASC')
    else
      all
    end
  end

  scope :filter_by_tags, -> (tags) { where("tags_ids && ARRAY[?]", tags)}
  scope :filter_by_authors, -> (authors) { includes(:user).where(["users.id IN (?)", authors])}
  scope :privates, -> { where(private: true)}
  #scope :count_posts_by_tags, -> (limit=100) { joins(:tags).order('count(*) desc').limit(limit).group(['tags.name', 'tags.id']).count }
  #scope :count_posts_by_authors, -> (limit=100) { joins(:user).order('count(*) desc').limit(limit).group(['users.name', 'users.id']).count }

  def self.filter(filters, count={})
    alter_filters(filters)
    posts = Post.all
    posts = posts.filter_by_tags(filters[:tags]) if !count[:tags] and filters[:tags]
    posts = posts.filter_by_authors(filters[:authors]) if !count[:authors] and filters[:authors]
    posts = posts.privates if filters[:private]
    posts
  end

  def self.count_posts_by_tags(posts, limit=100)
    posts.joins(:tags).order('count(*) desc').limit(limit).group(['tags.name', 'tags.id']).count
  end

  def self.count_posts_by_authors(posts, limit=100)
    posts.joins(:user).order('count(*) desc').limit(limit).group(['users.name', 'users.id']).count
  end

  def self.count_private_posts(posts)
    posts.where(private: true).size
  end



  def self.alter_filters(filters)
    filters.each do |filter|
      if filter.last.kind_of?(Array)
        filter[1] = filter.last.try(:reject, &:blank?) 
        filters[filter.first.to_sym] = filter.last
      end
      filters.delete(filter.first.to_sym) if filter.last == "" || filter.last == "0" || filter.last == []
    end
    filters
  end


  def canEdit? (current_user = nil)
  	  self.can_modify || ( current_user and self.user == current_user )
  end

  def set_rating
    self.avg_rating = self.comments.average(:rating).to_f.round(2)
    self.save
  end

  def self.searchAll (key_word)
  	posts = self.basic_search(key_word)
  	posts += self.fuzzy_search(title: key_word)
  	posts += self.fuzzy_search(text: key_word)
    posts += self.includes(:user).where(["users.name ILIKE ?", "%#{key_word}%"])
    posts += self.includes(:tags).where(["tags.name ILIKE ?", "%#{key_word}%"])
  	posts.uniq
  end

  private
    def set_tags_ids
      self.tags_ids = self.tags.pluck(:id).map(&:to_s)
    end
end
