class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited?(user)
    logger.debug("book model: user")
    logger.debug(user.id)
    Rails.cache.delete('favorites')
    favorites.where(user_id: user.id).exists?
  end

  def favoriteCounts(user)
    favorites.where(user_id:user.id, book_id:id).count
  end

  def bookCommentCounts()
    book_comments.where(book_id:id).count
  end

  def self.search(search, word)
    if search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  def self.todayPostCounts(user)
    Book.where(user_id:user.id, created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day).count
  end

  def self.yesterdayPostCounts(user)
    Book.where(user_id:user.id, created_at: Time.zone.yesterday.beginning_of_day..Time.zone.yesterday.end_of_day).count
  end

  def self.thisWeekPostCounts(user)
    Book.where(user_id:user.id, created_at: Time.zone.today.beginning_of_week..Time.zone.today.end_of_week).count
  end

  def self.prevWeekPostCounts(user)
    Book.where(user_id:user.id, created_at: Time.zone.today.prev_week(:monday)..Time.zone.today.prev_week(:sunday)).count
  end

end
