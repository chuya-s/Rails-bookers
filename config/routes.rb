Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  devise_for :users
  get 'home/about'=>'homes#about'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comment, only: [:create]
  end
  delete 'books/:book_id/book_comment/:book_comment_id' => 'book_comments#destroy', as:'destroy_book_comment'

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end