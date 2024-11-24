class Journey < ApplicationRecord
  resourcify

  belongs_to :user
  belongs_to :course

  has_many :steps
  has_many :lessons, through: :steps
  has_many :cards, through: :lessons
  has_many :decks
  has_many :card_proficiencies

  delegate :language, to: :course

  after_create :add_user_as_student

  scope :accessible_by, -> (user) {
    return none if user.nil?

    with_roles([:student, :teacher], user)
  }

  def next_lesson
    course.lessons.ordered.where(id: steps.not_status_is_completed.pluck(:lesson_id)).first
  end

  def accessible_by?(user)
    return false if user.nil?

    user.has_role?(:student, self) || user.has_role?(:teacher, self)
  end

  def editable_by?(user)
    return false if user.nil?

    user.has_role?(:student, self)
  end

  protected

  def add_user_as_student
    user.add_role(:student, self)
  end
end
