class CreateChunks < ActiveRecord::Migration[8.0]
  def change
    create_table :chunks do |t|
      t.references :book, null: false, foreign_key: true
      t.integer :cursor
      t.text :text, null: false
      t.vector :embedding, limit: 384
    end
  end
end
