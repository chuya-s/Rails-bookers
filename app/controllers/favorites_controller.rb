class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(book_id:params[:book_id])
    @favorite.user_id = current_user.id
    @favorite.save
    redirect_to request.referer
  end
  def destroy
    bookId = params[:book_id]
    @favorite = Favorite.find_by(user_id:current_user.id, book_id:bookId)
    @favorite.delete
    redirect_to request.referer
  end
end
