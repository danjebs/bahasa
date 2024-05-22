# frozen_string_literal: true

class Forms::HiddenField < ViewComponent::Base
  def initialize(form:, field:, value:)
    @form = form
    @field = field
    @value = value
  end
end
