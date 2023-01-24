Rails.application.routes.draw do

  get 'maps/index'
# deviseのルーティング
  # ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
    get 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


# ユーザー側のルーティング
  scope module: :public do
    root to:"homes#top"
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    get "search_tag" => "post_images#search_tag"
    get "search_keyword" => "post_images#search_keyword"
    resources :post_images do
      resources :post_comments, only: [:create, :destroy]
    # get "maps#index"
    resources :maps, only: [:index]
    end
  end

# 管理者側のルーティング
  namespace :admin do
    resources :post_images, only: [:index, :show, :destroy]
  end



end
