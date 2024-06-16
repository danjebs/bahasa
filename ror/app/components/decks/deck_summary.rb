# frozen_string_literal: true

class Decks::DeckSummary < ViewComponent::Base

  def initialize(deck)
    @deck = deck
  end
end
