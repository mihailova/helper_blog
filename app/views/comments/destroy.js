$('#<%= dom_id(@comment) %>').fadeOut();
$('.post .show-rating').html('<%=rating_stars(@comment.post.avg_rating)%>')