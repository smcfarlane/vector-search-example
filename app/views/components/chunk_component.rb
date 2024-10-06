# frozen_string_literal: true

class ChunkComponent < ApplicationComponent
  def initialize(chunk:)
    @chunk = chunk
  end

  def view_template
    div(class: "flex gap-4 border-b border-zinc-100 pb-4") do
      div { plain @chunk.text }
      div do
        p do
          strong { "Location: " }
          plain @chunk.cursor
        end
      end
    end
  end
end
