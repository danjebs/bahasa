# frozen_string_literal: true

class Lessons::LessonRow < ViewComponent::Base
  def initialize(lesson:)
    @lesson = lesson
  end
end
