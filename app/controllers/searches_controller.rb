class SearchesController < ApplicationController
  def search
    @word = params[:word]
    @range = params[:range]
    search = params[:search]
    if @range == '1'
      @user = User.search(search, @word)
    else
      @book = Book.search(search, @word)
    end
  end
end
