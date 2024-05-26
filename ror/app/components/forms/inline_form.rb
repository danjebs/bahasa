# frozen_string_literal: true

class Forms::InlineForm < ViewComponent::Base
  def initialize(model:, fields:, cancel_href:, delete_href: nil, direction:)
    @model = model
    @fields = fields.compact
    @cancel_href = cancel_href
    @delete_href = delete_href
    @direction = direction

    @css = {
      row: { wrapper: "grid grid-cols-2 gap-2", field: "my-1", buttons: "flex flex-row gap-2" },
      col: { wrapper: "flex-grow gap-2 p-4", field: "", buttons: "flex flex-col gap-2" },
    }[direction]
  end
end
