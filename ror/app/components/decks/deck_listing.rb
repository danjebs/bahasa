# frozen_string_literal: true

class Decks::DeckListing < ViewComponent::Base

  def initialize(deck:)
    @deck = deck
  end
end
