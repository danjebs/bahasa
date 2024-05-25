# frozen_string_literal: true

class Forms::Form < ViewComponent::Base
  delegate :rich_text_area_tag, to: :helpers

  def initialize(model:, fields:, cancel_href:, delete_href: nil, is_modal: false)
    @model = model
    @fields = fields
    @cancel_href = cancel_href
    @cancel_data = is_modal ? { turbo_frame: "remote_modal" } : nil
    @delete_href = delete_href
  end
end
