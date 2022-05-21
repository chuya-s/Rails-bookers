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

end
