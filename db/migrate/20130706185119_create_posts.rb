class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.string :tags, array: true, default: '{}'
      t.boolean :private

      t.timestamps
    end
  end
end
