# frozen_string_literal: true

class UI::Atoms::ReorderHandle < ViewComponent::Base

  erb_template <<-ERB
    <button class="reorder-handle cursor-grab bg-white-100 hover:bg-gray-100 dark:hover:bg-gray-700 text-sm font-normal rounded-full">
      <%= render partial: "shared/icon", locals: { name: 'chevron-up-down' } %>
    </button>
  ERB

  def initialize()
  end
end
