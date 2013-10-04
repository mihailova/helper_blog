class Filter
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_accessor :tags, :authors, :private, :id, :private_posts_count

  def initialize(attributes={}, first_time=false)
    attributes.each do |name, value|
      send("#{name}=", value.kind_of?(Array) ? value.reject(&:blank?) : value)
    end
    if first_time
      Filter::Tag.all = Post.count_posts_by_tags(Post.filter(attributes, {tags: true}))
      Filter::Author.all = Post.count_posts_by_authors(Post.filter(attributes, {authors: true}))
      send("private_posts_count=", Post.count_private_posts(Post.filter(attributes)))
    end
  end


  def persisted?
    !(self.id.nil?)
  end

  class Tag < Filter
    attr_accessor :name, :id

    def self.all
      @all
    end

    def self.all=(params)
      @all = []
      params.each do |param|
        @all << self.new({name: "#{param.first.first} (#{param.last})", id: param.first.last.to_s})
      end
    end
  end

  class Author < Filter
    attr_accessor :name, :id

    def self.all
      @all
    end

    def self.all=(params)
      @all = []
      params.each do |param|
        @all << self.new({name: "#{param.first.first} (#{param.last})", id: param.first.last.to_s})
      end
    end
  end
end



