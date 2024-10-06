# frozen_string_literal: true

class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout
  include Phlex::Rails::Helpers::ContentFor

  def view_template
    html do
      head do
        title do
          whitespace
          content_for(:title) || "Vector Search"
        end
        meta(name: "viewport", content: "width=device-width,initial-scale=1")
        meta(name: "apple-mobile-web-app-capable", content: "yes")
        meta(name: "mobile-web-app-capable", content: "yes")
        whitespace
        csrf_meta_tags
        whitespace
        csp_meta_tag
        whitespace
        plain yield :head
        link(rel: "icon", href: "/icon.png", type: "image/png")
        link(rel: "icon", href: "/icon.svg", type: "image/svg+xml")
        link(rel: "apple-touch-icon", href: "/icon.png")
        whitespace
        # Includes all stylesheet files in app/views/stylesheets
        whitespace
        stylesheet_link_tag "tailwind",
                            "inter-font",
                            "data-turbo-track": "reload"
        whitespace
        stylesheet_link_tag :app, "data-turbo-track": "reload"
        whitespace
        javascript_importmap_tags
      end
      body(class: "dark:bg-zinc-800 dark:text-zinc-300") do
        whitespace
        header(
          class:
            "h-16 border-b border-zinc-400 flex justify-between items-center px-4"
        ) do
          h1(class: "uppercase") { "book search" }
          whitespace
        end
        whitespace
        main(class: "container mx-auto mt-12 px-5 flex") do
          whitespace
          plain yield
          whitespace
        end
      end
    end
  end
end
