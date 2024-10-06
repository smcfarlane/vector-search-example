# frozen_string_literal: true

class OllamaBase
  include Singleton

  BASE_URL = "http://localhost:11434"

  class ModelNotEnabled < StandardError; end

  class << self
    attr_accessor :model

    delegate :embeddings, :available?, :client, to: :instance
  end

  attr_reader :available, :client
  alias_method :available?, :available

  def model
    self.class.model
  end

  def initialize
    @available = false
    @client = Ollama.new(credentials: { address: BASE_URL })

    client.show({ name: model })
    @available = true
  rescue Ollama::Errors::RequestError => e
    raise e if Rails.env.development?
    @available = false
  end

  def embeddings(values)
    result = client.embed({ model: model, input: Array.wrap(values) })
    result.first.fetch("embeddings", [])
  rescue Ollama::Errors::RequestError => e
    raise e if Rails.env.development?
    []
  end

  def pull_model
    client.pull({ name: model })
  end
end
