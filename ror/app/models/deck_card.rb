class DeckCard < ApplicationRecord
  MAX_SCORE = 10
  MAX_TIME_TAKEN = 10

  belongs_to :deck
  belongs_to :card

  enum :status, {
    created: "created",
    started: "started",
    completed: "completed"
  }, prefix: :status_is

  enum :outcome, {
    none: "none",
    peek: "peek",
    hint: "hint",
    flash: "flash"
  }, prefix: :outcome_is

  acts_as_list scope: :deck

  scope :ordered, -> { order(position: :asc) }
end
