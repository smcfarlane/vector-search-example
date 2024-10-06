class Chunk < ApplicationRecord
  has_neighbors :embedding

  belongs_to :book

  before_save :generate_embedding

  searchkick(
    batch_size: 200,
    default_fields: [ :text ],
    merge_mappings: true,
    mappings: {
      properties: {
        vector: {
          type: "dense_vector",
          dims: 384,
          similarity: "cosine"
        }
      }
    }
  )

  def search_data
    {
      book_id: book_id,
      text: text,
      vector: embedding
    }
  end

  def generate_embedding
    self.embedding = AllMiniLm.embeddings(self.text).first
  end
end
