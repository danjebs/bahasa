# frozen_string_literal: true

class Lessons::LessonForm < ViewComponent::Base
  def initialize(lesson:)
    @lesson = lesson
  end
end
