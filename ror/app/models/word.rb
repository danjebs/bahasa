class Word < ApplicationRecord
  acts_as_list scope: :exercise

  belongs_to :exercise, touch: true

  validates :word, presence: true, uniqueness: { scope: :exercise_id }

  scope :ordered, -> { order(exercise_id: :asc, position: :asc) }
end
