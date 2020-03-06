Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats
    resources :cat_rental_requests, only: [:new, :create] do
    member do
      patch 'approve_or_deny'
    end
  end

  root to: redirect('/cats')
end
