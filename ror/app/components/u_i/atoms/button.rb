# frozen_string_literal: true

class UI::Atoms::Button < ViewComponent::Base

  erb_template <<-ERB
    <button data-action="<%= @action %>" class="<%= ["w-full", @css_color_classes, @css_size_classes].join(" ") %>">
      <div class="flex justify-center items-center gap-2">
        <%= render partial: "shared/icon", locals: { name: @icon, css_class: "h-5 w-5" } %>
        <%= @label %>
      </div>
    </button>
  ERB

  def initialize(action:, label: nil, size: :md, color: :red, data: nil, icon: nil)
    @label = label
    @icon = icon
    @action = action
    @data = data

    @css_size_classes = {
      xs: "py-1 px-2 text-sm font-normal rounded",
      sm: "py-1.5 px-3 text-sm font-normal rounded",
      md: "py-2 px-4 text-sm font-medium rounded-md",
      lg: "py-3 px-5 text-lg font-semibold rounded-md",
    }[size]

    @css_color_classes = {
      red: "bg-gradient-to-r from-primary-500 to-primary-600 hover:to-primary-500 text-white dark:from-primary-700 dark:to-primary-600 dark:hover:to-primary-700 dark:text-primary-100",
      gray: "bg-gray-100 hover:bg-gray-200 text-gray-700 dark:text-gray-200",
      white: "bg-white hover:bg-gray-100 text-gray-700 dark:bg-gray-700 dark:text-gray-200 dark:hover:bg-gray-800 border border-solid border-gray-200 dark:border-gray-500 shadow-sm",
    }[color]
  end
end
