# frozen_string_literal: true

class Lessons::LessonList < ViewComponent::Base
  def initialize(lessons:)
    @lessons = lessons
  end
end
