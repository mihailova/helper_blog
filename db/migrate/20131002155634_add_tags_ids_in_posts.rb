class AddTagsIdsInPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :tags_ids, :text, array: true
  	add_index :posts, :tags_ids
  end
end
