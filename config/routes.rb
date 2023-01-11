Rails.application.routes.draw do

# ユーザー側のルーティング
  scope module: :public do
    root to:"homes#top"
    resources :post_images
  end

# 管理者側のルーティング
  namespace :admin do
    resources :post_images, only: [:index, :show, :destroy]
  end



# deviseのルーティング
  # ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # ユーザーゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

end
