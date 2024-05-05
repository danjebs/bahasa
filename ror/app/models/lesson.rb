class Lesson < ApplicationRecord
  belongs_to :language

  has_many :cards
  has_many :exercises

  acts_as_list scope: :language_id

  validates :title, presence: true, uniqueness: { scope: :language_id }
end
