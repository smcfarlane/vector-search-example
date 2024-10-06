# frozen_string_literal: true

class ButtonComponent < ApplicationComponent
  def initialize(type: "button", name: nil, value: nil)
    @type = type
    @name = name
    @value = value
  end

  def view_template(&)
    button(
      class: "py-3 px-5 bg-zinc-600 text-zinc-50 hover:bg-zinc-400",
      name: @name,
      value: @value,
      type: @type,
      &)
  end
end
