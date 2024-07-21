# frozen_string_literal: true

class Lessons::LessonSidebar < ViewComponent::Base
  def initialize(lesson)
    @lesson = lesson
  end
end
