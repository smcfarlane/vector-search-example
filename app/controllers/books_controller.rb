class BooksController < ApplicationController
  def index
    render Books::IndexView.new(books: Book.all)
  end

  def show
    render Books::ShowView.new(book: Book.find(params[:id]), params: params)
  end
end
