Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  #book routes
  get "/books", to: "books#index"
  get "/books/:id", to: "books#show", as: :book
  get "/book/new", to: "books#new", as: :new_book
  post "/books", to: "books#create"
  delete "/books/:id", to: "books#destroy"

  #book_review routes
  get "/books/:book_id/review/new", to: "reviews#new", as: :new_book_review
  post "/books/:book_id/reviews", to: "reviews#create", as: :book_reviews
  delete "/books/:book_id/reviews/:id", to: "reviews#destroy", as: :book_review

  #book_author routes
  get "/books/:book_id/author/new", to: "authors#new", as: :new_book_author
  post "/books/:book_id/authors", to: "authors#create", as: :book_authors
  delete "/books/:book_id/authors/:id", to: "authors#destroy", as: :book_author

  #author routes
  get "/authors/:id", to: "authors#show"
  delete "/authors/:id", to: "authors#destroy", as: :author

  #review routes
  get "/reviews", to: "reviews#index"
  delete "/reviews/:id", to: "reviews#destroy", as: :review

end
