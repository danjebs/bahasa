# frozen_string_literal: true

class UI::Atoms::IconButton < ViewComponent::Base

  erb_template <<-ERB
    <button data-action="<%= @action %>" class="<%= ["w-full", @css_color_classes, @css_size_classes].join(" ") %>">
      <%= render partial: "shared/icon", locals: { name: @icon } %>
    </button>
  ERB

  def initialize(action:, size: :md, color: :red, data: nil, icon: nil)
    @icon = icon
    @action = action
    @data = data

    @css_size_classes = {
      sm: "text-sm font-normal rounded-md",
      md: "p-2 text-md font-medium rounded-md",
      lg: "p-3 text-lg font-semibold rounded-lg",
    }[size]

    @css_color_classes = {
      red: "bg-transparent border-none text-primary-500 hover:bg-gray-100 dark:bg-gray-700 dark:text-gray-300 dark:hover:text-primary-500 dark:hover:bg-gray-600",
      white: "border-2 bg-transparent border-solid border-primary-500 text-primary-500 hover:bg-primary-500 hover:text-white font-semibold",
      gray: "bg-transparent hover:bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-300 dark:hover:bg-gray-800",
    }[color]
  end
end
