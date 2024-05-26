# frozen_string_literal: true

class UI::Layout::Modal < ViewComponent::Base
  renders_one :trigger

  def initialize(model:, id:, heading:)
    @model = model
    @id = id
    @heading = heading
  end
end
