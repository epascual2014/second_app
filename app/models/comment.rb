class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body
  after_create :send_favorites_emails
  private

  def send_favorites_emails
    # every favorite assoc w/ post send email
    self.post.favorites.each do |favorite| 
      if favorite.user_id != self.user_id && favorite.user.email_favorites?
        FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
      end
    end
  end
end
