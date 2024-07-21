class DeckCard < ApplicationRecord
  MAX_SCORE = 10
  MAX_TIME_TAKEN = 10

  belongs_to :deck
  belongs_to :card

  attribute :status, default: -> { :created }
  attribute :outcome, default: -> { :none }
  attribute :direction, default: -> { rand(2) == 1 ? :from_base : :to_base }

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

  enum :direction, {
    from_base: "from_base",
    to_base: "to_base",
  }, prefix: :direction_is

  acts_as_list scope: :deck

  scope :ordered, -> { order(position: :asc) }

  def front
    direction_is_from_base? ? card.front : card.back
  end

  def back
    direction_is_from_base? ? card.back : card.front
  end

  def max_scoring_time
    front.split.size
  end
end
