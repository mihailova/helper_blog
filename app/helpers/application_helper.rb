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
end
