Rails.application.routes.draw do
  root to: redirect('/hrm_sessions')

  resources :hrm_sessions, only: [:index, :show]
end
