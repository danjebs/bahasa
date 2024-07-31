class Deck < ApplicationRecord
  belongs_to :journey
  belongs_to :step, optional: true
  has_many :deck_cards
  has_many :cards, through: :deck_cards

  attribute :status, default: -> { :created }

  enum :status, {
    created: "created",
    started: "started",
    completed: "completed",
  }, prefix: :status_is

  enum :difficulty, {
    mixed: "mixed",
    easy: "easy",
    medium: "medium",
    hard: "hard",
    ultra: "ultra",
  }, prefix: :difficulty_is

  validates :status, presence: true

  def card_types
    case difficulty
    when "easy" then %w[WordCard]
    when "medium" then %w[WordCard PhraseCard]
    when "hard" then %w[PhraseCard TranslationCard]
    when "ultra" then %w[TranslationCard]
    else %w[WordCard PhraseCard TranslationCard]
    end
  end

  def next_deck_card
    if deck_cards.ordered.not_status_is_completed.exists?
      return deck_cards.ordered.not_status_is_completed.first
    end

    next_card = journey.cards.translated.with_types(card_types)
      .left_joins(:card_proficiencies)
      .for_lesson(step&.lesson)
      .where(card_proficiencies: { journey_id: [journey.id, nil] })
      .order(Arel.sql("card_proficiencies.score - (DATE_PART('day', card_proficiencies.updated_at - CURRENT_DATE))/7 NULLS FIRST, RANDOM ()"))
      .first

    deck_cards.create!(card_id: next_card.id)
  end

  def prune_deck_cards
    deck_cards.not_status_is_completed.destroy_all
  end
end
