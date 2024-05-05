# frozen_string_literal: true

class Lessons::LessonEdit < ViewComponent::Base
  def initialize(lesson:)
    @lesson = lesson
  end
end
