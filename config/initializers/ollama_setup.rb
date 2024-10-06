# ollama-ai gem does not have a method for the embed endpoint yet
module OllamaEndpointPatch
  def embed(payload, server_sent_events: nil, &callback)
    request("api/embed", payload, server_sent_events:, &callback)
  end
end
Ollama::Controllers::Client.include(OllamaEndpointPatch)
