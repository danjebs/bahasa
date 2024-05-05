# frozen_string_literal: true

class Lessons::LessonNew < ViewComponent::Base
  def initialize(lesson:)
    @lesson = lesson
  end
end
