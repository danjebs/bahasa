class Exercise < ApplicationRecord
  belongs_to :lesson

  validates :title, presence: true, uniqueness: { scope: :lesson_id }
  validates :type, presence: true
end
