# frozen_string_literal: true

class Forms::Form < ViewComponent::Base
  delegate :rich_text_area_tag, to: :helpers

  def initialize(model:, url: nil, fields:, cancel_href:, delete_href: nil, autofocus: true)
    @model = model
    @url = url.present? ? url : model
    @fields = fields.compact
    @cancel_href = cancel_href
    @delete_href = delete_href

    @autofocus = autofocus
  end
end
