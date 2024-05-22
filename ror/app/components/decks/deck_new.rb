# frozen_string_literal: true

class Decks::DeckNew < ViewComponent::Base

  def initialize(deck:)
    @deck = deck
  end
end
