class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :language
  has_many :steps
  has_many :lessons, through: :steps

  def next_lesson
    language.lessons.ordered.where.not(id: steps.not_status_is_completed.pluck(:lesson_id)).first
  end
end
