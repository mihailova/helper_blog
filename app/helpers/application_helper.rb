module ApplicationHelper






  def comments_form_url(post, comment)
    if comment.new_record?
      "/posts/#{post.id}/comments"
    else
      "/posts/#{post.id}/comments/#{comment.id}"
    end
  end

  def comments_form_class(comment)
    if comment.new_record?
      ""
    else
      "well"
    end
  end

  class RequestCurrentPath
    def initialize(fullpath)
      fullpath.gsub(/\?.*/, '')
      @current_path = fullpath
    end

    def active?(path)
      'active' if path == @current_path
    end
  end

  def nav_link_to(name = nil, path = nil)
    @request_path ||= RequestCurrentPath.new(request.fullpath)

    content_tag :li, class: @request_path.active?(path) do
      content_tag :a, href: path do
        name
      end
    end
  end


  def menu_link_to(name = nil, path = nil)
    @request_path ||= RequestCurrentPath.new(request.fullpath)

    content_tag :p, class: "menu #{@request_path.active?(path)}" do
      content_tag :a, href: path do
        name
      end
    end
  end

  def set_half_star(i)
    if i >= 1
      result = content_tag( :i, '', class: 'icon-star')
    elsif i <= 0    
      result = content_tag( :i, '', class: 'icon-star-empty')
    elsif i == 0.5
      result = content_tag( :i, '', class: 'icon-star-half-empty')
    elsif i < 0.5
      result = content_tag( :i, '', class: 'icon-star-empty')
    elsif i > 0.5
      result = content_tag( :i, '', class: 'icon-star')
    end    
    result
  end


  def rating_stars(rating)
    html = ""
    count = 0
    if rating == 0
      html = ""
    else
      5.times do
        html += set_half_star(rating)
        rating -= 1
      end
    end
    html.html_safe
  end

  def comment_author(comment)
    if comment.user
      comment.user.name
    elsif comment.user_name and comment.user_name != ""
      comment.user_name
    else
      'guest'
    end   
  end

  def set_star_rating(rating)
    html = ""
    i = 5
    5.times do
      html += content_tag(:span, '☆', value: "#{i}", class: rating==i ? "selected" : "")
      i -=1
    end
    html.html_safe
  end
end
