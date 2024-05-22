# frozen_string_literal: true

class Decks::CardSide < ViewComponent::Base
  renders_one :button_left
  renders_one :button_right

  def initialize(side:, hidden: false)
    @side = side
    @class_name = hidden ? "hidden" : ""
  end
end
