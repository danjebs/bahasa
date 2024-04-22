class Exercise < ApplicationRecord
  acts_as_list

  belongs_to :lesson

  validates :title, presence: true, uniqueness: { scope: :lesson_id }
  validates :type, presence: true
  validates :position, presence: true, uniqueness: { scope: :lesson_id }
end
