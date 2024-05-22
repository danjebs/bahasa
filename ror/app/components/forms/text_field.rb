# frozen_string_literal: true

class Forms::TextField < ViewComponent::Base
  def initialize(form:, field:)
    @form = form
    @field = field
  end
end
