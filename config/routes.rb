Rails.application.routes.draw do
  root "hrm_sessions#index"

  resources :hrm_sessions
end
