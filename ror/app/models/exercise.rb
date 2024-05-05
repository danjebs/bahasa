class Exercise < ApplicationRecord
  acts_as_list scope: :lesson

  belongs_to :lesson

  validates :title, presence: true, uniqueness: { scope: :lesson_id }
  validates :type, presence: true

  scope :ordered, -> { order(lesson_id: :asc, position: :asc) }
end
