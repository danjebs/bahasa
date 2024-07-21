# frozen_string_literal: true

class UI::Atoms::IconLink < ViewComponent::Base

  erb_template <<-ERB
    <%= link_to(
      @href,
      class: ["inline-block", @css_color_classes, @css_size_classes].join(" "),
      data: @data
    ) do
      %>
      <div class="flex justify-center items-center">
        <%= render partial: "shared/icon", locals: { name: @icon } %>
        <%= @label %>
      </div>
    <% end %>
  ERB

  def initialize(href:, size: :md, color: :red, data: nil, icon: nil)
    @icon = icon
    @href = href
    @data = data

    @css_size_classes = {
      sm: "p-1.5 text-sm font-normal rounded-md",
      md: "p-2 text-md font-medium rounded-md",
      lg: "p-3 text-lg font-semibold rounded-lg",
    }[size]

    @css_color_classes = {
      red: "bg-white text-primary-500 hover:bg-gray-100 dark:bg-gray-700 dark:text-primary-500 dark:hover:text-primary-500 dark:hover:bg-gray-600",
      gray: "bg-gray-100 hover:bg-gray-200 text-gray-700 dark:text-gray-200",
      white: "bg-white hover:bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-800",
    }[color]
  end
end
