class Phrase < ApplicationRecord
  acts_as_list scope: :exercise

  belongs_to :exercise, touch: true
  has_one :card, as: :cardable, dependent: :destroy

  validates :phrase, presence: true, uniqueness: { scope: :exercise_id }

  scope :ordered, -> { order(exercise_id: :asc, position: :asc) }

  after_create do
    card = PhraseCard.create(
      front: phrase,
      back: translation,
      lesson_id: exercise.lesson_id,
      cardable_type: 'Phrase',
      cardable_id: id,
    )
  end

  after_update do
    card.update(front: phrase, back: translation)
  end
end
