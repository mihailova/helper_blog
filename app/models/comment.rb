class Comment < ActiveRecord::Base
  RATING = [0, 1, 2, 3, 4, 5]
  belongs_to :post, counter_cache: true
  belongs_to :user

  validates :text, presence: true
  validates :rating, inclusion: { in: RATING }
  validates :post_id, presence: true

  after_save :update_post_avg_rating
  after_destroy :update_post_avg_rating

  def updated?
    self.created_at != self.updated_at
  end

  private
    def update_post_avg_rating
      self.post.set_rating
    end
end