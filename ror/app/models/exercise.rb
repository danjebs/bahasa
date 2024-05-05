class Exercise < ApplicationRecord

  belongs_to :lesson

  acts_as_list scope: :lesson

  validates :title, presence: true, uniqueness: { scope: :lesson_id }
  validates :type, presence: true

  scope :ordered, -> { order(lesson_id: :asc, position: :asc) }
end
