Rails.application.routes.draw do
  get 'book_comments/create'
  get 'book_comments/destroy'
  get 'books_comments/create'
  get 'books_comments/destroy'
  get 'favorites/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  devise_for :users
  get 'home/about'=>'homes#about'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end