class Card < ApplicationRecord
  belongs_to :lesson

  has_many :deck_cards, dependent: :destroy
  has_many :card_proficiencies

  acts_as_list scope: :lesson

  validates :type, presence: true
  validates :front, presence: true

  scope :ordered, -> { order(lesson_id: :asc, position: :desc) }
  scope :translated, -> { where.not(back: [nil, ""]) }
  scope :for_lesson, -> (lesson) { lesson.present? ? where(lesson_id: lesson.id) : all }
  scope :with_types, -> (types) { where(type: types) }
end
