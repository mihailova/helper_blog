class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :text, presence: true

  def updated?
    self.created_at != self.updated_at
  end
end
