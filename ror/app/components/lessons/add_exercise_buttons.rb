# frozen_string_literal: true

class Lessons::AddExerciseButtons < ViewComponent::Base
  def initialize(lesson:)
    @lesson = lesson
  end
end
