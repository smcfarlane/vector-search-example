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
    title: 'Dracula',
    author: 'Stoker, Bram, 1847-1912',
    file: '../../data/dracula.txt'
  },
  {
    title: 'Romeo and Juliet',
    author: 'Shakespeare, William, 1564-1616',
    file: '../../data/romeo_and_juliet.txt'
  },
  {
    title: 'The Hound of the Baskervilles',
    author: 'Conan Doyle, Arthur, 1859-1930',
    file: '../../data/the_hound_of_the_baskervilles.txt'
  }
].each do |data|
  book = Book.create(title: data[:title], author: data[:author])

  splitter = Baran::RecursiveCharacterTextSplitter.new(
    chunk_size: 512,
    chunk_overlap: 128,
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
