class Comment < ActiveRecord::Base
	RATING = [1, 2, 3, 4, 5]
  belongs_to :post
  belongs_to :user

  validates :text, presence: true
  validates :rating, presence: true
  validates :rating, inclusion: { in: RATING }
  validates :user_id, presence: true
  validates :post_id, presence: true

  def updated?
    self.created_at != self.updated_at
  end
end
