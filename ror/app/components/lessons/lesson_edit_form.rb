# frozen_string_literal: true

class Lessons::LessonEditForm < ViewComponent::Base
  def initialize(lesson:)
    @lesson = lesson
  end
end
