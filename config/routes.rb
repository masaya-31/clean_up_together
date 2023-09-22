Rails.application.routes.draw do
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
        get 'comments'
      end
    end
    resources :posts, only: [:index, :show, :destroy]
    resources :tags, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  #会員側
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :events, only: [:new, :index, :create, :edit, :update, :destroy]
    resources :members, only: [:show] do
      resource :relationships, only: [:create, :destroy]
      get "following" => "relationships#following", as: "following"
      get "favorite"
      get "unpublish", on: :collection
      collection do
        get 'edit_information' => 'members#edit'
        get 'login_edit'
        get 'email_edit'
        get 'password_edit'
        patch 'update'
        patch 'email_update'
        patch 'password_update'
      end
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end
end
