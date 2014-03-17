Bloccit::Application.routes.draw do

  get "posts/index"

  devise_for :users

  resources :users, only:[:show, :update]
  resources :users, only:[:show, :index]
  resources :posts, only:[:index]

  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
      match '/up-vote', to: 'votes#up_vote', as: :up_vote
      match '/down-vote', to: 'votes#down_vote', as: :down_vote
    end
  end
  
  match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end