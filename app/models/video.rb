class Video < ApplicationRecord
  validates :youtube_url, presence: true, uniqueness: false
  belongs_to :user, foreign_key: :created_by
  has_many :votes
  validates :youtube_url, presence: true, uniqueness: false
  before_save :create_watchable_url

  def like_by_user(user)
    user_id = user.is_a?(User) ? user.id : user
    votes.where(user_id: user_id).like.present?
  end

  def dislike_by_user(user)
    user_id = user.is_a?(User) ? user.id : user
    votes.where(user_id: user_id).dislike.present?
  end
  private
  def retrieve_video_id
    if youtube_url.to_s.include? '?'
      youtube_url.to_s.split('?').last.match(/v=([A-Za-z0-9_]+)&?.*$/).try(:[],1)
    elsif youtube_url.to_s.match(/(www\.youtube\.com|youtu\.be)\/.+/)
      youtube_url.to_s.split('/').last
    end
  end

  def create_watchable_url
    self.youtube_url = "https://www.youtube.com/embed/#{retrieve_video_id}"
  end
end
