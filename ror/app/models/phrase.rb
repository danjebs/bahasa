class Phrase < ApplicationRecord
  acts_as_list scope: :exercise

  belongs_to :exercise

  validates :phrase, presence: true, uniqueness: { scope: :exercise_id }

  scope :ordered, -> { order(exercise_id: :asc, position: :asc) }
end
