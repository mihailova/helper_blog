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
end
