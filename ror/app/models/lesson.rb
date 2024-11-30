class Lesson < ApplicationRecord
  resourcify

  belongs_to :course, touch: true

  has_many :cards, dependent: :destroy
  has_many :translation_cards, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :steps, dependent: :destroy

  delegate :language, to: :course
  delegate :editable_by?, to: :course

  broadcasts_refreshes

  acts_as_list scope: :course_id

  validates :title, presence: true, uniqueness: { scope: :course_id }

  after_create :create_steps_for_journeys

  scope :accessible_by, ->(user) {
    return none if user.nil?

    joins(course: :journeys).where(courses: { id: Journey.accessible_by(user).select(:course_id) })
  }
  scope :ordered, -> { order(course_id: :asc, position: :asc) }

  def accessible_by?(user)
    return false if user.nil?

    Journey.accessible_by(user).exists?(course_id: course_id)
  end

  private

  def create_steps_for_journeys
    course.journeys.each do |journey|
      steps.create!(journey: journey)
    end
  end
end
