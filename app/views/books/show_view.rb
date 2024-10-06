class Books::ShowView < ApplicationView
  include Phlex::Rails::Helpers::TurboFrameTag

  attr_accessor :params

  def initialize(book:, params:)
    @book = book
    @params = params
  end

  def view_template
    div(class: "flex flex-col gap-8 w-full") do
      div(class: "flex flex-col gap-2") do
        h1(class: "text-3xl") { @book.title }
        h3(class: "text-xl") { @book.author }
      end
      turbo_frame_tag :chunks_search do
        render BookSearchComponent.new(book: @book, query: params[:query])
      end
    end
  end
end
