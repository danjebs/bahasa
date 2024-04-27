class ExerciseWord < ApplicationRecord
  acts_as_list

  belongs_to :exercise

  validates :word, presence: true, uniqueness: { scope: :exercise_id }
  validates :position, presence: true, uniqueness: { scope: :exercise_id }

  scope :ordered, -> { order(exercise_id: :asc, position: :asc) }
end
