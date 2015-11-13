Rails.application.routes.draw do
  resources :cats

  resources :cat_rental_requests, only: [:create, :new] do
    member do
      post 'approve'
      post 'deny'
    end

  end

  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]

  root to: redirect("/cats")

end
