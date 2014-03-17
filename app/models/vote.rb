class Vote < ActiveRecord::Base
  belongs_to :post
  attr_accessible :user, :value, :post
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote."}
  after_save :update_post

  def update_post
    self.post.update_rank
  end

  def up_vote?
    value == 1
  end

  def down_vote?
    value == -1
  end
  private
end