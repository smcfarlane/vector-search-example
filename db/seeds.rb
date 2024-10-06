# frozen_string_literal: true

Chunk.delete_all
Book.delete_all

[
  {
    title: 'Frankenstein; Or, The Modern Prometheus',
    author: 'Shelley, Mary Wollstonecraft, 1797-1851',
    file: '../../data/frankenstein.txt'
  },
  {
    title: 'Dracula ',
    author: 'Stoker, Bram, 1847-1912',
    file: '../../data/dracula.txt'
  }
].each do |data|
  book = Book.create(title: data[:title], author: data[:author])

  splitter = Baran::RecursiveCharacterTextSplitter.new(
    chunk_size: 256,
    chunk_overlap: 64,
    separators: [ "\r\n\r\n", "\r\n", "\n\n", "\n", " ", "" ]
  )

  chunks = nil
  File.open(File.expand_path(data[:file], __FILE__), 'r') do |f|
    chunks = splitter.chunks(f.read)
    chunks.each do |c|
      book.chunks.create(cursor: c[:cursor], text: c[:text])
    end
  end
end
