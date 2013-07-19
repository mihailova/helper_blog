class AddCanModifyToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :can_modify, :boolean, default: true
  end
end
