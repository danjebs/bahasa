class Lesson < ApplicationRecord
  belongs_to :language, touch: true

  has_many :cards, dependent: :destroy
  has_many :translation_cards, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :steps, dependent: :destroy

  broadcasts_refreshes

  acts_as_list scope: :language_id

  validates :title, presence: true, uniqueness: { scope: :language_id }

  scope :ordered, -> { order(language_id: :asc, position: :asc) }
end
