class Card < ApplicationRecord
  belongs_to :lesson

  acts_as_list scope: :lesson

  validates :type, presence: true
  validates :front, presence: true

  scope :ordered, -> { order(lesson_id: :asc, position: :asc) }
end
