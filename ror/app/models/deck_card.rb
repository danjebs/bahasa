class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card

  enum :status, {
    created: "created",
    started: "started",
    completed: "completed"
  }, prefix: :status_is

  enum :outcome, {
    none: "none",
    hint: "hint",
    flash: "flash"
  }, prefix: :outcome_is

  acts_as_list scope: :deck

  scope :ordered, -> { order(position: :asc) }
end
