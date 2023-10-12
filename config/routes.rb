Rails.application.routes.draw do
  # ゲストログイン用
  devise_scope :member do
    post 'members/guest_sign_in', to: 'members/sessions#guest_sign_in'
  end

  # 会員用
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 管理者側
  namespace :admin do
    get 'search' => 'homes#search', as: 'search'
    resources :members, only: [:index, :edit, :update] do
      member do
        get 'posts'
        get 'post_comments'
      end
    end
    resources :posts, only: [:index, :show, :destroy]
    resources :tags, only: [:index, :destroy]
    resources :post_comments, only: [:index, :destroy]
  end

  #会員側
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    get "tags" => "tags#index"
    resources :events, only: [:new, :show, :index, :create, :edit, :update, :destroy]
    resources :members, only: [:show] do
      resource :relationships, only: [:create, :destroy]
      get "favorite", on: :member
      collection do
        get "following" => "relationships#following", as: "following"
        get "unpublish"
        get 'edit_information' => 'members#edit'
        get 'login_edit'
        get 'email_edit'
        patch 'update'
        patch 'email_update'
      end
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end
end
