# frozen_string_literal: true

class UI::Atoms::LinkButton < ViewComponent::Base

  erb_template <<-ERB
    <%= link_to(
          @href,
          id: @id,
          class: ["inline-block", @css_color_classes, @css_size_classes, @css_class].join(" "),
          data: @data
        ) do
    %>
      <div class="flex justify-center items-center">
        <%= render partial: "shared/icon", locals: { name: @icon } %>
        <%= @label %>
      </div>
    <% end %>
  ERB

  def initialize(href:, label: nil, id: nil, size: :md, color: :red, data: nil, icon: nil, css_class: "")
    @label = label
    @id = id
    @icon = icon
    @href = href
    @data = data
    @css_class = css_class

    @css_size_classes = {
      xs: "py-1 px-2 text-sm font-normal rounded",
      sm: "py-1.5 px-3 text-sm font-normal rounded",
      md: "py-3 px-4 text-base font-medium rounded-md",
      lg: "py-4 px-5 text-lg font-semibold rounded-md",
    }[size]

    @css_color_classes = {
      red: "bg-gradient-to-r from-primary-500 to-primary-600 hover:to-primary-500 text-white dark:from-primary-700 dark:to-primary-600 dark:hover:to-primary-700 dark:text-primary-100",
      white: "border-2 bg-transparent border-solid border-primary-500 text-primary-500 hover:bg-primary-500 hover:text-white font-semibold",
      gray: "bg-white hover:bg-gray-100 text-gray-700 dark:bg-gray-700 dark:text-gray-200 dark:hover:bg-gray-800 border border-solid border-gray-200 dark:border-gray-500 shadow-sm",
    }[color]
  end
end
