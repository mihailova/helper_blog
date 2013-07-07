class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.text :tags, array: true
      t.boolean :private

      t.timestamps
    end
  end
end
