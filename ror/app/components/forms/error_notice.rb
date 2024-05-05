# frozen_string_literal: true

class Forms::ErrorNotice < ViewComponent::Base
  def initialize(model:)
    @model = model
  end
end
