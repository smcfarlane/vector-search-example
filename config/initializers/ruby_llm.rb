require "ruby_llm"

RubyLLM.configure do |config|
  # Set keys for the providers you need. Using environment variables is best practice.
  config.gemini_api_key = ENV.fetch("GEMINI_API_KEY", nil)
end
