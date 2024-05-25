# frozen_string_literal: true

class Forms::Form < ViewComponent::Base
  delegate :rich_text_area_tag, to: :helpers

  def initialize(model:, fields:, cancel_href:, delete_href: nil)
    @model = model
    @fields = fields.compact
    @cancel_href = cancel_href
    @delete_href = delete_href
  end
end
