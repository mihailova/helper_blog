class AddEditorIndexToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :last_editor_id, :integer
  	add_index :posts, :last_editor_id
  end
end
