class Books::IndexView < ApplicationView
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Routes

  def initialize(books:)
    @books = books
  end

  def view_template
    ul do
      @books.each do |book|
        li(class: "mb-2") do
          link_to book_path(book), class: "hover:text-white" do
            plain book.title
            plain " | "
            plain book.author
          end
        end
      end
    end
  end
end
