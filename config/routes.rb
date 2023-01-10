Rails.application.routes.draw do

  namespace :admin do
    get 'post_images/index'
    get 'post_images/show'
  end
  namespace :public do
    get 'post_images/index'
    get 'post_images/show'
    get 'post_images/edit'
  end
  scope module: :public do
    root to:"homes#top"
  end


  # ユーザー用
  # URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

end
