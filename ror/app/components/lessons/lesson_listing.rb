# frozen_string_literal: true

class Lessons::LessonListing < ViewComponent::Base
  def initialize(lesson:)
    @lesson = lesson
  end
end
