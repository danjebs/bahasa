# frozen_string_literal: true

class Forms::RichTextField < ViewComponent::Base
  def initialize(form:, field:)
    @form = form
    @field = field
  end
end
