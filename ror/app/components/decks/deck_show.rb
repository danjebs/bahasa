# frozen_string_literal: true

class Decks::DeckShow < ViewComponent::Base

  def initialize(deck:)
    @deck = deck
  end
end
