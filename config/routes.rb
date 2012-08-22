Tree::Application.routes.draw do
  root :to => "categories#index"
  resources :categories
end
