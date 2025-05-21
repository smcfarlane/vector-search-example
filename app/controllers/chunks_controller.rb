class ChunksController < ApplicationController
  def index
  end

  def search
    book = Book.find(params[:book_id])
    query_embedding = AllMiniLm.embeddings(params[:query]).first
    chunks =
      if params[:commit] == "pg"
        Chunk
        .where(book: book)
        .nearest_neighbors(
          :embedding,
          query_embedding,
          distance: "taxicab")
        .first(20)
      elsif params[:commit] == "es"
        Chunk.search(body: {
          knn: {
            field: "vector",
            query_vector: query_embedding
          },
          size: 20,
          timeout: "11000ms"
        }).results
      end
    render Chunks::SearchView.new(
      book: book,
      chunks: chunks,
      query: params[:query])
  end
end
