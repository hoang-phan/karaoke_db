Rails.application.routes.draw do
  resources :data_links, only: :index
end
