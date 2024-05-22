# frozen_string_literal: true

class Decks::DeckList < ViewComponent::Base

  def initialize(decks:)
    @decks = decks
  end
end
