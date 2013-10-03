class SetDefaultValueToAvgRating < ActiveRecord::Migration
  def change
  	change_column :posts, :avg_rating, :float, default: 0
  end
end
