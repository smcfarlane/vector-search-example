# frozen_string_literal: true

class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout
  include Phlex::Rails::Helpers::ContentFor
  include Phlex::Rails::Helpers::LinkTo

  def view_template
    html do
      head do
        title do
          content_for(:title) || "Vector Search"
        end
        meta(name: "viewport", content: "width=device-width,initial-scale=1")
        meta(name: "apple-mobile-web-app-capable", content: "yes")
        meta(name: "mobile-web-app-capable", content: "yes")
        csrf_meta_tags
        csp_meta_tag
        plain yield :head
        link(rel: "icon", href: "/icon.png", type: "image/png")
        link(rel: "icon", href: "/icon.svg", type: "image/svg+xml")
        link(rel: "apple-touch-icon", href: "/icon.png")
        # Includes all stylesheet files in app/views/stylesheets
        stylesheet_link_tag "tailwind",
                            "inter-font",
                            "data-turbo-track": "reload"
        stylesheet_link_tag :app, "data-turbo-track": "reload"
        javascript_importmap_tags
      end
      body(class: "dark:bg-zinc-800 dark:text-zinc-300") do
        header(
          class:
            "h-16 border-b border-zinc-400 flex justify-between items-center px-4"
        ) do
          link_to root_path do
            h1(class: "uppercase") { "book search" }
          end
        end
        main(class: "container mx-auto mt-12 px-5 flex") do
          yield
        end
      end
    end
  end
end
