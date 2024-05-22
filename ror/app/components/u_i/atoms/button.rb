# frozen_string_literal: true

class UI::Atoms::Button < ViewComponent::Base

  erb_template <<-ERB
    <button data-action="<%= @action %>" class="<%= ["w-full", @css_color_classes, @css_size_classes].join(" ") %>">
      <div class="flex justify-center items-center">
        <%= render partial: "shared/icon", locals: { name: @icon } %>
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
      sm: "py-1.5 px-3 text-sm font-normal rounded-full",
      md: "py-3 px-4 text-base font-medium rounded-full",
      lg: "py-4 px-5 text-lg font-semibold rounded-full",
    }[size]

    @css_color_classes = {
      red: "bg-rose-100 hover:bg-rose-200 text-rose-600 dark:border-rose-700 dark:hover:bg-red-700 textdark:-red-700 dark:hover:text-gray-700",
      # red: "border-2 border-solid border-red-600 hover:bg-red-600 text-red-600 hover:text-white dark:border-red-700 dark:hover:bg-red-700 textdark:-red-700 dark:hover:text-gray-700",
      gray: "bg-gray-100 hover:bg-gray-200 text-gray-700 dark:text-gray-200",
      white: "bg-white-100 hover:bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-200 dark:hover:bg-gray-700",
    }[color]
  end
end
