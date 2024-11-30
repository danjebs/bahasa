class Exercise < ApplicationRecord
  broadcasts_refreshes

  belongs_to :lesson, touch: true

  acts_as_list scope: :lesson

  validates :title, presence: true, uniqueness: { scope: :lesson_id }
  validates :type, presence: true

  scope :ordered, -> { order(lesson_id: :asc, position: :asc) }

  delegate :language, to: :lesson
end
