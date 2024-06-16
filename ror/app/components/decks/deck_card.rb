# frozen_string_literal: true

class Decks::DeckCard < ViewComponent::Base

  def initialize(deck_card)
    @deck_card = deck_card
  end
end
