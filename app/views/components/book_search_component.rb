# frozen_string_literal: true

class BookSearchComponent < ApplicationComponent
  include Phlex::Rails::Helpers::FormTag
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::TextFieldTag

  def initialize(book:, query:)
    @book = book
    @query = query
  end

  def view_template
    div(class: "flex justify-center w-full") do
      form_tag book_chunks_search_path(@book), class: "w-3/4 flex flex-col gap-4" do
        text_field_tag :query, @query, class: "text-zinc-900 w-full"
        div(class: "flex justify-center gap-4") do
          render ButtonComponent.new(type: "submit", name: "commit", value: "pg") { "Pgvector Search" }
          render ButtonComponent.new(type: "submit", name: "commit", value: "es") { "Elasticsearch Search" }
        end
      end
    end
  end
end
