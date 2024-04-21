# frozen_string_literal: true

class LinkButton < ViewComponent::Base

  erb_template <<-ERB
    <%= link_to(
          @href,
          class: ["inline-block", @css_color_classes, @css_size_classes].join(" "),
          data: @data
        ) do
    %>
      <div class="flex items-center">
        <%= render partial: "shared/icon", locals: { name: @icon } %>
        <%= @label %>
      </div>
    <% end %>
  ERB

  def initialize(href:, label: nil, size: :md, color: :red, data: nil, icon: nil)
    @label = label
    @icon = icon
    @href = href
    @data = data

    @css_size_classes = {
      sm: "py-1.5 px-3 text-sm font-normal rounded",
      md: "py-3 px-4 text-base font-medium rounded-md",
      lg: "py-4 px-5 text-lg font-semibold rounded-md",
    }[size]

    @css_color_classes = {
      red: "bg-red-600 hover:bg-red-700 text-white",
      gray: "bg-gray-100 hover:bg-gray-200 text-gray-700",
      white: "bg-white-100 hover:bg-gray-100 text-gray-700",
    }[color]
  end
end
