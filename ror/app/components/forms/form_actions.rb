# frozen_string_literal: true

class Forms::FormActions < ViewComponent::Base
  renders_many :fields

  def initialize(form:, cancel_href: nil, is_modal: false)
    @form = form
    @cancel_href = cancel_href
    @cancel_data = is_modal ? { turbo_frame: "remote_modal" } : nil
  end
end
