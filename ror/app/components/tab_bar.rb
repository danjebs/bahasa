# frozen_string_literal: true

class TabBar < ViewComponent::Base
  renders_many :sections

  erb_template <<-ERB
    <div>
      <div class="sm:hidden">
        <label for="Tab" class="sr-only">Tab</label>

        <select id="Tab" class="w-full rounded-md border-gray-200">
          <% @tabs.map do |tab| %>
            <option><%= tab %></option>
          <% end %>
        </select>
      </div>

      <div class="hidden sm:block">
        <div class="border-b border-gray-200 dark:border-gray-500">
          <nav class="-mb-px flex gap-6" aria-label="Tabs">
            <% @tabs.map do |tab| %>
              <a
                href="#<%= tab %>"
                class="shrink-0 border-b-2 border-transparent px-1 pb-4 text-sm font-medium text-gray-500 hover:border-gray-300 hover:text-gray-700 dark:text-gray-400 dark:hover:border-gray-600 dark:hover:text-gray-300"
              >
                <%= tab %>
              </a>
            <% end %>
          </nav>
        </div>
      </div>
    </div>
    <% sections.each_with_index do |section, i| %>
      <div class="mb-6 " id="<%= @tabs[i] %>" data-tab-id="<%= @tabs[i] %>">
        <%= section %>
      </div>
    <% end %>
  ERB

  def initialize(tabs: [])
    @tabs = tabs
  end
end
