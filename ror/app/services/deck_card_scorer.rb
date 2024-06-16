class DeckCardScorer < ApplicationService
  def initialize(deck_card:)
    @deck_card = deck_card
  end

  def call
    score_deck_card
  end

  private

  def score_deck_card
    multiplier = case @deck_card.outcome
    when "flash"
      DeckCard::MAX_SCORE
    when "hint"
      DeckCard::MAX_SCORE / 2
    else
      0
    end

    deck_card_outcomes = DeckCard.joins(:deck)
      .where(card_id: @deck_card.card_id, deck: { journey_id: @deck_card.deck.journey_id })
      .order(created_at: :desc)
      .limit(3)
      .pluck(:outcome, :time_taken)

    proficiency_score = 0
    deck_card_outcomes.each do |outcome, time_taken|
      break unless outcome == "flash"

      proficiency_score += [(DeckCard::MAX_TIME_TAKEN - time_taken) / (DeckCard::MAX_TIME_TAKEN / 3), 0].max
    end

    card_proficiency = CardProficiency.find_or_create_by(
      journey_id: @deck_card.deck.journey_id,
      card_id: @deck_card.card_id
    )
    card_proficiency.update(score: proficiency_score)
  end
end
