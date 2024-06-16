class Deck < ApplicationRecord
  belongs_to :journey
  has_many :deck_cards
  has_many :cards, through: :deck_cards

  enum :status, {
    created: "created",
    started: "started",
    completed: "completed"
  }, prefix: :status_is

  enum :difficulty, {
    easy: 1,
    normal: 2,
    hard: 3
  }, prefix: :difficulty_is

  enum :duration, {
    quick: 1,
    medium: 2,
    long: 3,
    marathon: 4
  }, prefix: :duration_is

  validates :status, presence: true
  validates :difficulty, presence: true
  validates :duration, presence: true

  def next_deck_card
    deck_cards.ordered.not_status_is_completed.first
  end
end
