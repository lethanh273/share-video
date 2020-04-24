class Video < ApplicationRecord
  validates :youtube_url, presence: true, uniqueness: false
  belongs_to :user, foreign_key: :created_by
  has_many :votes

  def like_by_user(user)
    user_id = user.is_a?(User) ? user.id : user
    votes.where(user_id: user_id).like.present?
  end

  def dislike_by_user(user)
    user_id = user.is_a?(User) ? user.id : user
    votes.where(user_id: user_id).dislike.present?
  end

end
