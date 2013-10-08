class SetDefaulValueToRating < ActiveRecord::Migration
  def change
  	change_column :comments, :rating, :int, default: 0
  end
end
