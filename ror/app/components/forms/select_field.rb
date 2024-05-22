# frozen_string_literal: true

class Forms::SelectField < ViewComponent::Base
  def initialize(form:, field:, options:)
    @form = form
    @field = field
    @options = options
  end
end
