# frozen_string_literal: true

class UI::Layout::Modal < ViewComponent::Base
  renders_one :heading

  def initialize(id:)
    @id = id
  end
end
