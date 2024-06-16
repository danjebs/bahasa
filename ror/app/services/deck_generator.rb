class DeckGenerator < ApplicationService
  def initialize(journey_id:, difficulty:, duration:, status: :created)
    @journey_id = journey_id
    @difficulty = difficulty
    @duration = duration
    @status = status
  end

  def call
    generate_deck
  end

  private

  def generate_deck
    journey = Journey.find(@journey_id)

    deck = Deck.create!(
      journey_id: @journey_id,
      difficulty: @difficulty,
      duration: @duration,
      status: @status
    )

    journey.cards
      .left_joins(:card_proficiencies)
      .where(card_proficiencies: { journey_id: [journey.id, nil] })
      .order(Arel.sql("card_proficiencies.score - (DATE_PART('day', card_proficiencies.updated_at - CURRENT_DATE))/7 NULLS FIRST"))
      .each do |card|
      deck.deck_cards.create(
        card_id: card.id,
        status: :created,
        outcome: :none
      )
    end

    deck
  end
end
