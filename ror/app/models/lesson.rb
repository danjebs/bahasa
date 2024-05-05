class Lesson < ApplicationRecord
  belongs_to :language

  has_many :cards
  has_many :exercises

  validates :title, presence: true, uniqueness: { scope: :language_id }
end
