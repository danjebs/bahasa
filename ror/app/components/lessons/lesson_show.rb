# frozen_string_literal: true

class Lessons::LessonShow < ViewComponent::Base
  def initialize(lesson:)
    @lesson = lesson
  end
end
