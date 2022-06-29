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
    Book.where(user_id:user.id, created_at: Time.current.beginning_of_day..Time.current.end_of_day).count
  end

  def self.yesterdayPostCounts(user)
    Book.where(user_id:user.id, created_at: Time.current.yesterday.beginning_of_day..Time.current.yesterday.end_of_day).count
  end

  def self.twodaysPostCounts(user)
    Book.where(user_id:user.id, created_at: 2.days.ago.beginning_of_day..2.days.ago.end_of_day).count
  end

  def self.threedaysPostCounts(user)
    Book.where(user_id:user.id, created_at: 3.days.ago.beginning_of_day..3.days.ago.end_of_day).count
  end

  def self.fourdaysPostCounts(user)
    Book.where(user_id:user.id, created_at: 4.days.ago.beginning_of_day..4.days.ago.end_of_day).count
  end

  def self.fivedaysPostCounts(user)
    Book.where(user_id:user.id, created_at: 5.days.ago.beginning_of_day..5.days.ago.end_of_day).count
  end

  def self.sixdaysPostCounts(user)
    Book.where(user_id:user.id, created_at: 6.days.ago.beginning_of_day..6.days.ago.end_of_day).count
  end

  def self.thisWeekPostCounts(user)
    Book.where(user_id:user.id, created_at: Time.current.beginning_of_week..Time.current.end_of_week).count
  end

  def self.prevWeekPostCounts(user)
    Book.where(user_id:user.id, created_at: Time.current.prev_week(:monday)..Time.current.prev_week(:sunday)).count
  end

end
