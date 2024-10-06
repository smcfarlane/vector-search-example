# frozen_string_literal: true

class Chunks::SearchView < ApplicationView
  include Phlex::Rails::Helpers::TurboFrameTag

  def initialize(book:, chunks:, query:)
    @book = book
    @chunks = chunks
    @query = query
  end

  def view_template
    turbo_frame_tag :chunks_search do
      render BookSearchComponent.new(book: @book, query: @query)
      div(class: "flex flex-col gap-8 pt8") do
        @chunks.each do |chunk|
          render ChunkComponent.new(chunk: chunk)
        end
      end
    end
  end
end
